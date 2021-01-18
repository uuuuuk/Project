package com.ode.airplane;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.ws.ResponseWrapper;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class airplaneService {
	
	/* 공공데이터포털 인증키 */
	final String key = "qUcTXdjOpu4%2Fp2%2BpA6k7e8clCyoVk%2Bk3EAx8O41%2FQ3AjrpoSSC0M7jr6wxG%2BMErlQlgANMZHEhQmdsDbrqargA%3D%3D";

	/*	-----------------------------------------------------------------------------
		|		공항명		|  IATA코드	|	    공항ID		|		      위도 & 경도	 		|
	 	-----------------------------------------------------------------------------
		|	  	군산			|	 KUV	|	 NAARKJK	|	lat=35.907&lon=126.622	|
		|	  	광주			|	 KJW	|	 NAARKJJ	|	lat=35.124&lon=126.803	|
		|	  	김포			|	 GMP	|	 NAARKSS	|	lat=37.561&lon=126.801	|
		|	  	김해			|	 PUS	|	 NAARKPK	|	lat=35.180&lon=128.936	|
		|    	대구			|	 TAE	|	 NAARKTN	|	lat=35.896&lon=128.656	|
		|	  	무안			|	 MWX	|	 NAARKJB	|	lat=34.993&lon=126.386	|
		|    	사천			|	 HIN	|	 NAARKPS	|	lat=35.089&lon=128.067	|
		|	  	양양			|	 YNY	|	 NAARKNY	|	lat=38.059&lon=128.667	|
		|	  	여수			|	 RSU	|	 NAARKJY	|	lat=34.842&lon=127.616	|
		|	  	울산			|	 USN	|	 NAARKPU	|	lat=35.593&lon=129.352	|
		|	  	원주			|	 WJU	|	 NAARKNW	|	lat=37.439&lon=127.966	|
		|	  	인천			|	 ICN	|	 NAARKSI	|	lat=37.464&lon=126.441	|
		|	  	제주			|	 CJU	|	 NAARKPC	|	lat=33.506&lon=126.491	|
		|	  	청주			|	 CJJ	|	 NAARKTU	|	lat=36.715&lon=127.496	|
		|	  	포항			|	 KPO	|	 NAARKTH	|	lat=35.986&lon=129.422	|
		-----------------------------------------------------------------------------*/
	Map<String, String> airID = new HashMap<String,String>();
	{
		airID.put("군산", "NAARKJK");
		airID.put("광주", "NAARKJJ");
		airID.put("김포", "NAARKSS");
		airID.put("김해", "NAARKPK");
		airID.put("대구", "NAARKTN");
		airID.put("무안", "NAARKJB");
		airID.put("사천", "NAARKPS");
		airID.put("양양", "NAARKNY");
		airID.put("여수", "NAARKJY");
		airID.put("울산", "NAARKPU");
		airID.put("원주", "NAARKNW");
		airID.put("인천", "NAARKSI");
		airID.put("제주", "NAARKPC");
		airID.put("청주", "NAARKTU");
		airID.put("포항", "NAARKTH");
		
	}
	Map<String, String> map = new HashMap<String, String>();
	{
		// 공항 ID -> 공항위치(위도&경도) 
		map.put("NAARKJK", "KUV");	// 군산공항
		map.put("NAARKJJ", "KJW");	// 광주공항
		map.put("NAARKSS", "GMP");	// 김포공항
		map.put("NAARKPK", "PUS");	// 김해공항
		map.put("NAARKTN", "TAE");	// 대구공항
		map.put("NAARKJB", "MWX");	// 무안공항
		map.put("NAARKPS", "HIN");	// 사천공항
		map.put("NAARKNY", "YNY");	// 양양공항
		map.put("NAARKJY", "RSU");	// 여수공항
		map.put("NAARKPU", "USN");	// 울산공항
		map.put("NAARKNW", "WJU");	// 원주공항
		map.put("NAARKSI", "ICN");	// 인천공항
		map.put("NAARKPC", "CJU");	// 제주공항
		map.put("NAARKTU", "CJJ");	// 청주공항
		map.put("NAARKTH", "KPO");	// 포항공항
	}
	
	Map<String, String> airName = new HashMap<String, String>();
	{
		airName.put("에어부산", 	"AirBusan.png");
		airName.put("에어서울", 	"AirSeoul.png");
		airName.put("아시아나항공", "AsianaAir.png");
		airName.put("이스타항공", 	"EstarJet.png");
		airName.put("제주항공", 	"JejuAir.png");
		airName.put("진 에어", 	"JinAir.png");
		airName.put("대한 항공", 	"KoreanAir.png");
		airName.put("티웨이항공", 	"Tway.png");
	}
	
	/* 항공권 조회 */
	@SuppressWarnings("finally")
	public List<Map<String,Object>>  airplaneSearch(String depAirport, String arrAirport, String depTime) {
		System.out.println("depAirport: " + depAirport + ", arrAirport: " + arrAirport + ", depTime: " + depTime);
		List<Map<String,Object>> airlineList = new ArrayList<Map<String,Object>>();
		StringBuilder sb = null;

		try {
			
			StringBuilder urlBuilder = new StringBuilder("http://openapi.tago.go.kr/openapi/service/DmstcFlightNvgInfoService/getFlightOpratInfoList"); // URL
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + key); 											// 인증키
			urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(depAirport, "UTF-8")); 		// 출발공항ID
			urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(arrAirport, "UTF-8")); 		// 도착공항ID
			urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depTime, "UTF-8")); 		// 가는날
			urlBuilder.append("&" + "_type=json");
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode());  // 응답코드
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
			}
			sb = new StringBuilder();
			String line;
			String totalStr;
			while ((line = rd.readLine()) != null) {
					sb.append(line);	
			}
			
			// JSON데이터 파싱 (response - body - items -item)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONObject response = (JSONObject) total.get("response");
			JSONObject body 	= (JSONObject) response.get("body");
			JSONObject items 	= (JSONObject) body.get("items");
			JSONArray  item 	= (JSONArray)  items.get("item");
			
			for(int i = 0 ; i < item.size() ; i++){
				
				JSONObject col 		= (JSONObject) item.get(i);
				String airlineNm 	= (String) 	col.get("airlineNm");		// 항공사명
				String depAirportNm = (String) 	col.get("depAirportNm");	// 출발공항
				Long depPlandTime 	= (Long)	col.get("depPlandTime");	// 출발시간
				String arrAirportNm = (String) 	col.get("arrAirportNm");	// 도착공항
				Long arrPlandTime	= (Long) 	col.get("arrPlandTime");	// 도착시간
				Long economyCharge	= (Long) 	col.get("economyCharge");	// 운임
				String vihicleId	= (String) 	col.get("vihicleId");		// 항공편명
				
				String airlineImg = airName.get(airlineNm);	// 이미지파일명 매핑해서 가져오기
				
				String depDate = Long.toString(depPlandTime);
				String TimeD = Long.toString(depPlandTime);
				String TimeA = Long.toString(arrPlandTime);
				
				Map<String,Object> colMap = new HashMap<String,Object>();
				
					colMap.put("depTime", 	depTime);	// 이전/다음 날짜 조회에 사용할 값 저장
					colMap.put("airlineNm", 	airlineNm);
					colMap.put("airlineImg", 	airlineImg);
					colMap.put("depAirportNm", 	depAirportNm);
					colMap.put("depPlandTime", 	TimeD.substring(8, 10) + ":" + TimeD.substring(10, 12));
					colMap.put("arrAirportNm", 	arrAirportNm);
					colMap.put("arrPlandTime", 	TimeA.substring(8, 10) + ":" + TimeA.substring(10, 12));
					colMap.put("economyCharge", economyCharge);
					colMap.put("vihicleId", 	vihicleId);
					colMap.put("depDate", depDate.substring(4, 6) + " / " + depDate.substring(6, 8));
					
					if(!colMap.containsValue(null)){	// 항공편 정보가 부족할 경우 조회목록에서 제외하고 Map에 저장
						airlineList.add(colMap);
					}
			}
			rd.close(); 
			conn.disconnect();
			System.out.println("항공권 JSON data : " + sb.toString());
			
		} catch (Exception e) {
			System.out.println("항공 검색 실패 " + e);
		} finally{
			return airlineList;
		}
		
	}
	
	/* 공항주차장 조회 */
	public List<Map<String, Object>> airportParkCheck(String depAirportNm) {
		
		String IATA = map.get(depAirportNm);	// 공항명에 해당하는 IATA 공항코드 값 가져오기
		List<Map<String,Object>> parkList = new ArrayList<Map<String,Object>>();
		StringBuilder sb = null;
		
		try {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.airport.co.kr/service/rest/AirportParking/airportparkingRT"); 	// URL
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") 	+ "=" + key); 												// 인증키
			urlBuilder.append("&" + URLEncoder.encode("schAirportCode","UTF-8") + "=" + URLEncoder.encode(IATA, "UTF-8"));  			// 공항명
			urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") 			+ "=" + URLEncoder.encode("json", "UTF-8")); 					// 변환TYPE
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode()); // 응답코드
			BufferedReader rd;
			
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
			}
			
			sb = new StringBuilder();
			String line;
			String totalStr = "";
			
			while ((line = rd.readLine()) != null) {
			    sb.append(line);
			}
			
			rd.close();
			conn.disconnect();
			System.out.println("공항 주차장 정보 JSON data : " + sb.toString());
			
			// JSON데이터 파싱 (response - body - items -item)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONObject response = (JSONObject) total.get("response");
			JSONObject body 	= (JSONObject) response.get("body");
			JSONObject items 	= (JSONObject) body.get("items");
			JSONArray  item 	= (JSONArray)  items.get("item");
			
			for(int i = 0 ; i < item.size() ; i++){
				
				JSONObject col = (JSONObject) item.get(i);
				String 	parkingAirportCodeName 	= (String) 	col.get("parkingAirportCodeName");	// 주차장명
				Long	parkingFullSpace 		= (Long) 	col.get("parkingFullSpace");		// 총주차공간
				String 	parkingGetdate			= (String) 	col.get("parkingGetdate");			// 업데이트일자
				String 	parkingGettime 			= (String) 	col.get("parkingGettime");			// 업데이트시간
				Long 	parkingIstay 			= (Long) 	col.get("parkingIstay");			// 현재 주차수
			
				Map<String,Object> colMap = new HashMap<String,Object>();
				
				colMap.put("parkingAirportCodeName", parkingAirportCodeName);
				colMap.put("parkingFullSpace", parkingFullSpace);
				colMap.put("parkingIstay", parkingIstay);
				colMap.put("parkingIempty", parkingFullSpace - parkingIstay);
				colMap.put("parkingGetdate", parkingGetdate);
				colMap.put("parkingGettime", parkingGettime);
				
				parkList.add(colMap);
			}
			
			
		} catch (UnsupportedEncodingException e) {
			System.out.println("주차장 메서드 에러 EncodingException"+ e);
		} catch (MalformedURLException e) {
			System.out.println("주차장 메서드 에러 MalformedURLException"+ e);
		} catch (ProtocolException e) {
			System.out.println("주차장 메서드 에러 ProtocolException"+ e);
		} catch (IOException e) {
			System.out.println("주차장 메서드 에러 IOException"+ e);
		} catch (ParseException e) {
			System.out.println("주차장 메서드 에러 ParseException"+ e);
		}
		
		return parkList;
	}

	/* 공항날씨 조회 */
/*	public String airportWeather(String depAirportNm){
		
		String result = map.get(depAirportNm);
		// System.out.println("출발공항 : " + depAirportNm);
		// System.out.println("위도 경도 : " + result);
		String apiUrl = "http://api.openweathermap.org/data/2.5/weather?" + 	// URL
						"&lat=35&lon=129" + 									// 위도&경도
						
						"&appid=a79479d2d982619acbd0468021a88e8f";				// 인증키
		String icon = null;
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		
		try {
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			
			BufferedReader rd;
			
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
			}
			
			StringBuilder sb = new StringBuilder();
			String line;
			String totalStr = "";
			
			while ((line = rd.readLine()) != null) {
			    sb.append(line);
			}
			
			conn.disconnect();
//			System.out.println("공항날씨 JSON data : " + sb.toString());
			
			// JSON데이터 파싱 (weather - 0)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONArray  weather 	= (JSONArray)  total.get("weather");
			JSONObject arrIdx 	= (JSONObject) weather.get(0);
			icon = (String) arrIdx.get("icon");
			
		} catch (MalformedURLException e) {
			System.out.println("날씨조회 메서드 에러 MalformedURLException"+ e);
		} catch (ProtocolException e) {
			System.out.println("날씨조회 메서드 에러 ProtocolException"+ e);
		} catch (IOException e) {
			System.out.println("날씨조회 메서드 에러 IOException"+ e);
		} catch (ParseException e) {
			System.out.println("날씨조회 메서드 에러 ParseException"+ e);
		}
		
		return icon;
	}*/
	/* 항공권 조회 */
	@SuppressWarnings("unchecked")
	public JSONArray  airplaneReSearch(String SearchdepAirportNm, String SearcharrAirportNm, String depTime) {
		String depAirport = airID.get(SearchdepAirportNm);
		String arrAirport = airID.get(SearcharrAirportNm);
		System.out.println("depAirport: " + depAirport + ", arrAirport: " + arrAirport + ", depTime: " + depTime);
		JSONArray airlineList = new JSONArray();
		StringBuilder sb = null;

		try {
			
			StringBuilder urlBuilder = new StringBuilder("http://openapi.tago.go.kr/openapi/service/DmstcFlightNvgInfoService/getFlightOpratInfoList"); // URL
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + key); 											// 인증키
			urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(depAirport, "UTF-8")); 		// 출발공항ID
			urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(arrAirport, "UTF-8")); 		// 도착공항ID
			urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depTime, "UTF-8")); 		// 가는날
			urlBuilder.append("&" + "_type=json");
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode());  // 응답코드
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
			    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
			}
			sb = new StringBuilder();
			String line;
			String totalStr;
			while ((line = rd.readLine()) != null) {
					sb.append(line);	
			}
			
			// JSON데이터 파싱 (response - body - items -item)
			totalStr = sb.toString();
			JSONParser parser 	= new JSONParser();
			JSONObject total 	= (JSONObject) parser.parse(totalStr);
			JSONObject response = (JSONObject) total.get("response");
			JSONObject body 	= (JSONObject) response.get("body");
			JSONObject items 	= (JSONObject) body.get("items");
			JSONArray  item 	= (JSONArray)  items.get("item");
			
			for(int i = 0 ; i < item.size() ; i++){
				
				JSONObject col 		= (JSONObject) item.get(i);
				String airlineNm 	= (String) 	col.get("airlineNm");		// 항공사명
				String depAirportNm = (String) 	col.get("depAirportNm");	// 출발공항
				Long depPlandTime 	= (Long)	col.get("depPlandTime");	// 출발시간
				String arrAirportNm = (String) 	col.get("arrAirportNm");	// 도착공항
				Long arrPlandTime	= (Long) 	col.get("arrPlandTime");	// 도착시간
				Long economyCharge	= (Long) 	col.get("economyCharge");	// 운임
				String vihicleId	= (String) 	col.get("vihicleId");		// 항공편명
				
				String airlineImg = airName.get(airlineNm);	// 이미지파일명 매핑해서 가져오기
				
				String depDate = Long.toString(depPlandTime);
				String TimeD = Long.toString(depPlandTime);
				String TimeA = Long.toString(arrPlandTime);
				
				JSONObject colMap = new JSONObject();
				
					colMap.put("depTime", 	depTime);	// 이전/다음 날짜 조회에 사용할 값 저장
					colMap.put("airlineNm", 	airlineNm);
					colMap.put("airlineImg", 	airlineImg);
					colMap.put("depAirportNm", 	depAirportNm);
					colMap.put("depPlandTime", 	TimeD.substring(8, 10) + ":" + TimeD.substring(10, 12));
					colMap.put("arrAirportNm", 	arrAirportNm);
					colMap.put("arrPlandTime", 	TimeA.substring(8, 10) + ":" + TimeA.substring(10, 12));
					colMap.put("economyCharge", economyCharge);
					colMap.put("vihicleId", 	vihicleId);
					colMap.put("depDate", depDate.substring(4, 6) + " / " + depDate.substring(6, 8));
					
					if(!colMap.containsValue(null)){	// 항공편 정보가 부족할 경우 조회목록에서 제외하고 Map에 저장
						airlineList.add(colMap);
					}
			}
			rd.close(); 
			conn.disconnect();
			System.out.println("항공권 JSON data : " + sb.toString());
			
		} catch (UnsupportedEncodingException e) {
			System.out.println("항공권 조회 메서드 에러 EncodingException"+ e);
		} catch (MalformedURLException e) {
			System.out.println("항공권 조회 메서드 에러 MalformedURLException"+ e);
		} catch (ProtocolException e) {
			System.out.println("항공권 조회 메서드 에러 ProtocolException"+ e);
		} catch (IOException e) {
			System.out.println("항공권 조회 메서드 에러 IOException"+ e);
		} catch (ParseException e) {
			System.out.println("항공권 조회 메서드 에러 ParseException"+ e);
		}	
		
		return airlineList;
	}
}



