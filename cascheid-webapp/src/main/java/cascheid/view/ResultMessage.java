package cascheid.view;

import java.util.HashMap;
import java.util.Map;

public class ResultMessage {

	private String resultMessage;
	private boolean isError = false;
	private Map<String, String> responses = new HashMap<String, String>();
	
	public String getResultMessage() {
		return resultMessage;
	}
	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}
	public boolean isError() {
		return isError;
	}
	public void setError(boolean isError) {
		this.isError = isError;
	}
	public Map<String, String> getResponses() {
		return responses;
	}
	public void setResponses(Map<String, String> responses) {
		this.responses = responses;
	}
	public void addResponse(String key, String value){
		responses.put(key, value);
	}
}
