package shop;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.jcraft.jsch.*;

public class ShopBookDBBean {

    private static String user = "p201606023";
    private static String password = "pp201606023";
    private static String host = "l.bsks.ac.kr";
    private static int port = 22;

    private static String r_host = "localhost";
    private static int l_port = 4321;
    private static int r_port = 3306;

    private static Connection conn = null;
    private static PreparedStatement pstmt = null;
    private static ResultSet rs = null;

    private static String url = "jdbc:mysql://" + r_host +":" + l_port + "/";
    private static String db = "p201606023";
    private static String dbUser = "p201606023";
    private static String dbPasswd = "pp201606023";

    private static ShopBookDBBean instance;

    private ShopBookDBBean() {}

    public static ShopBookDBBean getInstance() throws Exception {

        if(instance==null)
        {
            instance = new ShopBookDBBean();
            JSch jsch = new JSch();
            Session j_session = jsch.getSession(user, host, port);

            j_session.setPassword(password);
            j_session.setConfig("StrictHostKeyChecking", "no");
            System.out.println("Establishing Connection...");
            j_session.connect();
            int assinged_port = j_session.setPortForwardingL(l_port, r_host, r_port);
            System.out.println("localhost:"+assinged_port+" -> "+ r_host +":"+ r_port);

            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection(url+db, dbUser, dbPasswd);
            System.out.println("connection");
        }
        return instance;
    }

   private Connection getConnection() throws Exception {
        return DriverManager.getConnection(url+db, dbUser, dbPasswd);
    }

    public int managerCheck(String id, String passwd)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int x=-1;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select managerPasswd from manager where managerId = ? ");
            pstmt.setString(1, id);

            rs= pstmt.executeQuery();

            if(rs.next()){
                dbpasswd= rs.getString("managerPasswd");
                if(dbpasswd.equals(passwd))
                    x= 1; //인증 성공
                else
                    x= 0; //비밀번호 틀림
            }else
                x= -1;//해당 아이디 없음

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }

    //책 등록 메소드
    public void insertBook(ShopBookDataBean book)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "insert into book values (?,?,?,?,?,?,?,?,?,?,?,?)");
            pstmt.setInt(1,book.getBook_id());
            pstmt.setString(2, book.getBook_kind());
            pstmt.setString(3, book.getBook_title());
            pstmt.setInt(4, book.getBook_price());
            pstmt.setShort(5, book.getBook_count());
            pstmt.setString(6, book.getAuthor());
            pstmt.setString(7, book.getPublishing_com());
            pstmt.setString(8, book.getPublishing_date());
            pstmt.setString(9, book.getBook_image());
            pstmt.setString(10, book.getBook_content());
            pstmt.setByte(11,book.getDiscount_rate());
            pstmt.setTimestamp(12, book.getReg_date());

            pstmt.executeUpdate();

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    // 전체등록된 책의 수를 얻어내는 메소드
    public int getBookCount()
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select count(*) from book");
            rs = pstmt.executeQuery();

            if (rs.next())
                x= rs.getInt(1);
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }

    // 분류별또는 전체등록된 책의 정보를 얻어내는 메소드
    public List<ShopBookDataBean> getBooks(String book_kind)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ShopBookDataBean> bookList=null;

        try {
            conn = getConnection();

            String sql1 = "select * from book";
            String sql2 = "select * from book ";
            sql2 += "where book_kind = ? order by reg_date desc";

            if(book_kind.equals("all")){
                pstmt = conn.prepareStatement(sql1);
            }else{
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, book_kind);
            }
            rs = pstmt.executeQuery();

            if (rs.next()) {
                bookList = new ArrayList<ShopBookDataBean>();
                do{
                    ShopBookDataBean book= new ShopBookDataBean();

                    book.setBook_id(rs.getInt("book_id"));
                    book.setBook_kind(rs.getString("book_kind"));
                    book.setBook_title(rs.getString("book_title"));
                    book.setBook_price(rs.getInt("book_price"));
                    book.setBook_count(rs.getShort("book_count"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublishing_com(rs.getString("publishing_com"));
                    book.setPublishing_date(rs.getString("publishing_date"));
                    book.setBook_image(rs.getString("book_image"));
                    book.setDiscount_rate(rs.getByte("discount_rate"));
                    book.setReg_date(rs.getTimestamp("reg_date"));

                    bookList.add(book);
                }while(rs.next());
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return bookList;
    }

    // 쇼핑몰 메인에 표시하기 위해서 사용하는 분류별 신간책목록을 얻어내는 메소드
    public ShopBookDataBean[] getBooks(String book_kind,int count)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ShopBookDataBean bookList[]=null;
        int i=0;

        try {
            conn = getConnection();

            String sql = "select * from book where book_kind = ? ";
            sql += "order by reg_date desc limit ?,?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, book_kind);
            pstmt.setInt(2, 0);
            pstmt.setInt(3, count);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                bookList = new ShopBookDataBean[count];
                do{
                    ShopBookDataBean book= new ShopBookDataBean();
                    book.setBook_id(rs.getInt("book_id"));
                    book.setBook_kind(rs.getString("book_kind"));
                    book.setBook_title(rs.getString("book_title"));
                    book.setBook_price(rs.getInt("book_price"));
                    book.setBook_count(rs.getShort("book_count"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublishing_com(rs.getString("publishing_com"));
                    book.setPublishing_date(rs.getString("publishing_date"));
                    book.setBook_image(rs.getString("book_image"));
                    book.setDiscount_rate(rs.getByte("discount_rate"));
                    book.setReg_date(rs.getTimestamp("reg_date"));

                    bookList[i]=book;

                    i++;
                }while(rs.next());
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return bookList;
    }

    // bookId에 해당하는 책의 정보를 얻어내는 메소드로
    //등록된 책을 수정하기 위해 수정폼으로 읽어들기이기 위한 메소드
    public ShopBookDataBean getBook(int bookId)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ShopBookDataBean book=null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select * from book where book_id = ?");
            pstmt.setInt(1, bookId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                book = new ShopBookDataBean();

                book.setBook_kind(rs.getString("book_kind"));
                book.setBook_title(rs.getString("book_title"));
                book.setBook_price(rs.getInt("book_price"));
                book.setBook_count(rs.getShort("book_count"));
                book.setAuthor(rs.getString("author"));
                book.setPublishing_com(rs.getString("publishing_com"));
                book.setPublishing_date(rs.getString("publishing_date"));
                book.setBook_image(rs.getString("book_image"));
                book.setBook_content(rs.getString("book_content"));
                book.setDiscount_rate(rs.getByte("discount_rate"));
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return book;
    }

    // 등록된 책의 정보를 수정시 사용하는 메소드
    public void updateBook(ShopBookDataBean book, int bookId)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql;

        try {
            conn = getConnection();

            sql = "update book set book_kind=?,book_title=?,book_price=?";
            sql += ",book_count=?,author=?,publishing_com=?,publishing_date=?";
            sql += ",book_image=?,book_content=?,discount_rate=?";
            sql += " where book_id=?";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, book.getBook_kind());
            pstmt.setString(2, book.getBook_title());
            pstmt.setInt(3, book.getBook_price());
            pstmt.setShort(4, book.getBook_count());
            pstmt.setString(5, book.getAuthor());
            pstmt.setString(6, book.getPublishing_com());
            pstmt.setString(7, book.getPublishing_date());
            pstmt.setString(8, book.getBook_image());
            pstmt.setString(9, book.getBook_content());
            pstmt.setByte(10, book.getDiscount_rate());
            pstmt.setInt(11, bookId);

            pstmt.executeUpdate();

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    // bookId에 해당하는 책의 정보를 삭제시 사용하는 메소드
    public void deleteBook(int bookId)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "delete from book where book_id=?");
            pstmt.setInt(1, bookId);

            pstmt.executeUpdate();

        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    //BuyDBBean
    // bank테이블에 있는 전체 레코드를 얻어내는 메소드
    public List<String> getAccount(){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<String> accountList = null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select * from bank");
            rs = pstmt.executeQuery();

            accountList = new ArrayList<String>();

            while (rs.next()) {
                String account = new String(rs.getString("account")+" "
                        + rs.getString("bank")+" "+rs.getString("name"));
                accountList.add(account);
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return accountList;
    }

    //구매 테이블인 buy에 구매목록 등록
    public void insertBuy( List<CartDataBean> lists,
                           String id, String account, String deliveryName, String deliveryTel,
                           String deliveryAddress) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Timestamp reg_date = null;
        String sql = "";
        String maxDate =" ";
        String number = "";
        String todayDate = "";
        String compareDate = "";
        long buyId = 0;
        short nowCount ;
        try {
            conn = getConnection();
            reg_date = new Timestamp(System.currentTimeMillis());
            todayDate = reg_date.toString();
            compareDate = todayDate.substring(0, 4) + todayDate.substring(5, 7) + todayDate.substring(8, 10);

            pstmt = conn.prepareStatement("select max(buy_id) from buy");

            rs = pstmt.executeQuery();
            rs.next();
            if (rs.getLong(1) > 0){
                Long val = new Long(rs.getLong(1));
                maxDate = val.toString().substring(0, 8);
                number =  val.toString().substring(8);
                if(compareDate.equals(maxDate)){
                    if((Integer.parseInt(number)+1)<10000)
                        buyId = Long.parseLong(maxDate + (Integer.parseInt(number)+1+10000));
                    else
                        buyId = Long.parseLong(maxDate + (Integer.parseInt(number)+1));
                }else{
                    compareDate += "00001";
                    buyId = Long.parseLong(compareDate);
                }
            }else {
                compareDate += "00001";
                buyId = Long.parseLong(compareDate);
            }
            //103~151라인까지 하나의 트랜잭션으로 처리
            conn.setAutoCommit(false);
            for(int i=0; i<lists.size();i++){
                //해당 아이디에 대한 cart테이블 레코드를을 가져온후 buy테이블에 추가
                CartDataBean cart = lists.get(i);

                sql = "insert into buy (buy_id,buyer,book_id,book_title,buy_price,buy_count,";
                sql += "book_image,buy_date,account,deliveryName,deliveryTel,deliveryAddress)";
                sql += " values (?,?,?,?,?,?,?,?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);

                pstmt.setLong(1, buyId);
                pstmt.setString(2, id);
                pstmt.setInt(3, cart.getBook_id());
                pstmt.setString(4, cart.getBook_title());
                pstmt.setInt(5, cart.getBuy_price());
                pstmt.setByte(6, cart.getBuy_count());
                pstmt.setString(7, cart.getBook_image());
                pstmt.setTimestamp(8, reg_date);
                pstmt.setString(9, account);
                pstmt.setString(10, deliveryName);
                pstmt.setString(11, deliveryTel);
                pstmt.setString(12, deliveryAddress);
                pstmt.executeUpdate();

                //상품이 구매되었으므로 book테이블의 상품수량을 재조정함
                pstmt = conn.prepareStatement(
                        "select book_count from book where book_id=?");
                pstmt.setInt(1, cart.getBook_id());
                rs = pstmt.executeQuery();
                rs.next();

                nowCount = (short)(rs.getShort(1) - cart.getBuy_count());

                sql = "update book set book_count=? where book_id=?";
                pstmt = conn.prepareStatement(sql);

                pstmt.setShort(1, nowCount);
                pstmt.setInt(2, cart.getBook_id());

                pstmt.executeUpdate();
            }

            pstmt = conn.prepareStatement(
                    "delete from cart where buyer=?");
            pstmt.setString(1, id);

            pstmt.executeUpdate();

            conn.commit();
            conn.setAutoCommit(true);
        }catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    //id에 해당하는 buy테이블의 레코드수를 얻어내는 메소드
    public int getListCount(String id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select count(*) from buy where buyer=?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                x= rs.getInt(1);
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }

    //buy테이블의 전체 레코드수를 얻어내는 메소드
    public int getListCount()
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select count(*) from buy");
            rs = pstmt.executeQuery();

            if (rs.next()) {
                x= rs.getInt(1);
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }

    //id에 해당하는 buy테이블의 구매목록을 얻어내는 메소드
    public List<BuyDataBean> getBuyList(String id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BuyDataBean buy=null;
        String sql = "";
        List<BuyDataBean> lists = null;

        try {
            conn = getConnection();

            sql = "select * from buy where buyer = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            lists = new ArrayList<BuyDataBean>();

            while (rs.next()) {
                buy = new BuyDataBean();

                buy.setBuy_id(rs.getLong("buy_id"));
                buy.setBook_id(rs.getInt("book_id"));
                buy.setBook_title(rs.getString("book_title"));
                buy.setBuy_price(rs.getInt("buy_price"));
                buy.setBuy_count(rs.getByte("buy_count"));
                buy.setBook_image(rs.getString("book_image"));
                buy.setSanction(rs.getString("sanction"));

                lists.add(buy);
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return lists;
    }

    //buy테이블의 전체 목록을 얻어내는 메소드
    public List<BuyDataBean> getBuyList()
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BuyDataBean buy=null;
        String sql = "";
        List<BuyDataBean> lists = null;

        try {
            conn = getConnection();

            sql = "select * from buy";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            lists = new ArrayList<BuyDataBean>();

            while (rs.next()) {
                buy = new BuyDataBean();

                buy.setBuy_id(rs.getLong("buy_id"));
                buy.setBuyer(rs.getString("buyer"));
                buy.setBook_id(rs.getInt("book_id"));
                buy.setBook_title(rs.getString("book_title"));
                buy.setBuy_price(rs.getInt("buy_price"));
                buy.setBuy_count(rs.getByte("buy_count"));
                buy.setBook_image(rs.getString("book_image"));
                buy.setBuy_date(rs.getTimestamp("buy_date"));
                buy.setAccount(rs.getString("account"));
                buy.setDeliveryName(rs.getString("deliveryName"));
                buy.setDeliveryTel(rs.getString("deliveryTel"));
                buy.setDeliveryAddress(rs.getString("deliveryAddress"));
                buy.setSanction(rs.getString("sanction"));

                lists.add(buy);
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return lists;
    }


    //CustomerDBBean
    //회원가입
    public void insertMember(CustomerDataBean member)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "insert into member values (?,?,?,?,?)");
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPasswd());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getTel());
            pstmt.setString(5, member.getAddress());

            pstmt.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    public int userCheck(String id, String passwd) //사용자 인증처리
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int x=-1;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select passwd from member where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();

            if(rs.next()){
                dbpasswd= rs.getString("passwd");
                if(dbpasswd.equals(passwd))
                    x= 1; //인증 성공
                else
                    x= 0; //비밀번호 틀림
            }else
                x= -1;//해당 아이디 없음
        }catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }

    public int confirmId(String id) throws Exception //중복아이디 체크
            {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        int x = -1;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select id from member where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();
            if(rs.next())
                x=1;
            else
                x=-1;
        }catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }

    //회원정보를 수정하기 위해 기존의 정보를 표시
    public CustomerDataBean getMember(String id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CustomerDataBean member=null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select * from member where id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new CustomerDataBean();

                member.setId(rs.getString("id"));
                member.setPasswd(rs.getString("passwd"));
                member.setName(rs.getString("name"));
                member.setReg_date(rs.getTimestamp("reg_date"));
                member.setTel(rs.getString("tel"));
                member.setAddress(rs.getString("address"));
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return member;
    }

    public void updateMember(CustomerDataBean member) //회원의 정보수정
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "update member set passwd=?,name=?,tel=?,address=? "+
                            "where id=?");
            pstmt.setString(1, member.getPasswd());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getTel());
            pstmt.setString(4, member.getAddress());
            pstmt.setString(5, member.getId());

            pstmt.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    public int deleteMember(String id, String passwd) //회원탈퇴
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int x=-1;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select passwd from member where id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if(rs.next()){
                dbpasswd= rs.getString("passwd");
                if(dbpasswd.equals(passwd)){
                    pstmt = conn.prepareStatement(
                            "delete from member where id=?");
                    pstmt.setString(1, id);
                    pstmt.executeUpdate();
                    x= 1; //회원탈퇴 성공
                }else
                    x= 0; //비밀번호 틀림
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }


    //CartDataBean
    //[장바구니에 담기]를 클릭하면 수행되는 것으로 cart 테이블에 새로운 레코드를 추가
    public void insertCart(CartDataBean cart)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql="";

        try {
            conn = getConnection();
            sql = "insert into cart (book_id, buyer," +
                    "book_title,buy_price,buy_count,book_image) " +
                    "values (?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, cart.getBook_id());
            pstmt.setString(2, cart.getBuyer());
            pstmt.setString(3, cart.getBook_title());
            pstmt.setInt(4, cart.getBuy_price());
            pstmt.setByte(5, cart.getBuy_count());
            pstmt.setString(6, cart.getBook_image());

            pstmt.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    //id에 해당하는 레코드의 수를 얻어내는 메소드
    public int getListCountCart(String id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select count(*) from cart where buyer=?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                x= rs.getInt(1);
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }


    //id에 해당하는 레코드의 목록을 얻어내는 메소드
    public List<CartDataBean> getCart(String id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CartDataBean cart=null;
        String sql = "";
        List<CartDataBean> lists = null;

        try {
            conn = getConnection();

            sql = "select * from cart where buyer = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            lists = new ArrayList<CartDataBean>();

            while (rs.next()) {
                cart = new CartDataBean();

                cart.setCart_id(rs.getInt("cart_id"));
                cart.setBook_id(rs.getInt("book_id"));
                cart.setBook_title(rs.getString("book_title"));
                cart.setBuy_price(rs.getInt("buy_price"));
                cart.setBuy_count(rs.getByte("buy_count"));
                cart.setBook_image(rs.getString("book_image"));

                lists.add(cart);
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (rs != null)
                try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
        return lists;
    }

    //장바구니에서 수량을 수정시 실행되는 메소드
    public void updateCount(int cart_id, byte count)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "update cart set buy_count=? where cart_id=?");
            pstmt.setByte(1, count);
            pstmt.setInt(2, cart_id);

            pstmt.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    //장바구니에서 cart_id에대한 레코드를 삭제하는 메소드
    public void deleteList(int cart_id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "delete from  cart where cart_id=?");
            pstmt.setInt(1, cart_id);

            pstmt.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {

            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

    //id에 해당하는 모든 레코드를 삭제하는 메소드로 [장바구니 비우기]단추를 클릭시 실행된다.
    public void deleteAll(String id)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "delete from cart where buyer=?");
            pstmt.setString(1, id);

            pstmt.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
            if (pstmt != null)
                try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null)
                try { conn.close(); } catch(SQLException ex) {}
        }
    }

}