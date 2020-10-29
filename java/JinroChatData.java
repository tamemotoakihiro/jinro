package jinro;

public class JinroChatData	{

		private int			chat_id;	//id
    private int     user_id; //
		private String  user_name;
		private String	sentence; //sentence

		/*		*/
		public JinroChatData(){}

		/*		*/
		JinroChatData(int chat_id,int user_id, String user_name, String sentence){
				this.chat_id				=chat_id;
        this.user_id        =user_id;
				this.user_name			=user_name;
        this.sentence       =sentence;
		}

		/*		*/
		public void setChatId(int chat_id){
				this.chat_id = chat_id;
		}
		public int getChatId(){
				return this.chat_id;
		}

    public void setUserId(int user_id){
				this.user_id = user_id;
		}
		public int getUserId(){
				return this.user_id;
		}

    public void setUserName(String user_name){
				this.user_name = user_name;
		}
		public String getUserName(){
				return this.user_name;
		}

		public void setSentence(String sentence){
				this.sentence = sentence;
		}
		public String getSentence(){
				return this.sentence;
		}


}
