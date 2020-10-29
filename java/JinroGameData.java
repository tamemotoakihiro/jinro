package jinro;

public class JinroGameData	{

		private int			id;	//id
    private int     user_id; //ユーザー
		private String user_name;
		private int  vote_id; //投票した人
		private String	sentence; //弁明

		/*		*/
		public JinroGameData(){}

		/*		*/
		JinroGameData(int id, int user_id, String user_name, int vote_id, String sentence){

				this.id						= id;
        this.user_id      = user_id;
				this.user_name    = user_name;
				this.vote_id			= vote_id;
        this.sentence     = sentence;

		}

		/*		*/
		public void setId(int id){
				this.id = id;
		}
		public int getId(){
				return this.id;
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

		public void setVoteId(int vote_id){
				this.vote_id = vote_id;
		}
		public int getVoteId(){
				return this.vote_id;
		}

		public void setSentence(String sentence){
				this.sentence = sentence;
		}
		public String getSentence(){
				return this.sentence;
		}


}
