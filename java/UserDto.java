package jinro;

public class UserDto	{


  //+--------------+--------------+------+-----+---------+----------------+
  //| Field        | Type         | Null | Key | Default | Extra          |
  //+--------------+--------------+------+-----+---------+----------------+
  //| id           | int          | NO   | PRI | NULL    | auto_increment |
  //| user_name | varchar(50)  | YES  |     | NULL    |                |
  //| password      | varchar(100) | YES  |     | NULL    |                |

		private int			user_id;					  //id
		private String	user_name; //
		private String 	role_name;

		/*		*/
		public UserDto(){}

		/*		*/
		UserDto(int user_id,String user_name,	String role_name){
				this.user_id	=user_id;
        this.user_name =user_name;
				this.role_name =role_name;
		}

    /*		*/
		public void setUserId(int user_id){
				this.user_id = user_id;
		}
		public int getUserId(){
				return this.user_id;
		}

		public void setUser_name(String user_name){
				this.user_name = user_name;
		}
		public String getUser_name(){
				return this.user_name;
		}

		public void setRole_name(String role_name){
				this.role_name = role_name;
		}
		public String getRole_name(){
				return this.role_name;
		}



}
