import java.io.*;
import java.util.ArrayList;

public class day15 {
  @SuppressWarnings("unchecked")
  static ArrayList<String>[] keys = new ArrayList[256]; 
  @SuppressWarnings("unchecked")
  static ArrayList<String>[] values = new ArrayList[256]; 
  public static void main(String[] args) {
    try{

      if (args.length == 0) {
        System.err.println("ERROR: Invalid file path");
        System.exit(1);
      }
      String filePath = args[0];
      var input = new BufferedReader(new FileReader(filePath));
      int part1Result = 0;
      var line = input.readLine().split(",");
      for (var str:line) {
        part1Result += hash(str);
        if (str.contains("-")) {
          remove(str.substring(0, str.length() - 1));
        }else{
          var s = str.split("="); 
          set(s[0], s[1]);
        }
      }
      int part2Result = 0;
      for(int i = 0; i < keys.length; i++) {
        var listKeys = keys[i];
        if(listKeys != null){
          for(int j = 0; j < listKeys.size(); j++){
            String key = listKeys.get(j);
            int value = Integer.parseInt(get(key));
            part2Result += ((i + 1) * (j + 1) * value);
          }
        }
      }
      System.out.println("Part 1 -> " + part1Result);
      System.out.println("Part 2 -> " + part2Result);
      input.close();
    }catch(Exception e) {
      System.err.println(e);
      System.exit(1);
    }
  }

  static int hash(String str) {
    var bytes = str.getBytes();
    var result = 0;
    for(var bute : bytes) {
      result += bute;
      result *= 17;
      result %= 256;
    }
    return result;
  }

  static void set(String key, String value) {
    var hashKey = hash(key);
    if (keys[hashKey] == null) {
      keys[hashKey] = new ArrayList<String>();
      values[hashKey] = new ArrayList<String>();
    }
    var indexKey = keys[hashKey].indexOf(key); 
    if (indexKey != -1) {
      values[hashKey].set(indexKey, value);
    }else {
      keys[hashKey].add(key);
      values[hashKey].add(value);
    }
    return;
  }

  static void remove(String key) {
    var hashKey = hash(key);
    if(keys[hashKey] == null) {
      return;
    }
    var keyList = keys[hashKey];
    var index = keyList.indexOf(key);
    if(index == -1) {
      return;
    }
    keys[hashKey].remove(index);
    values[hashKey].remove(index);
    if (keys[hashKey].size() == 0) {
      keys[hashKey] = null;
      values[hashKey] = null;
    }
  }
  static String get(String key) {
    var hashKey = hash(key);
    if(keys[hashKey] == null) {
      return "";
    }
    var keyList = keys[hashKey];
    var index = keyList.indexOf(key);
    if(index == -1) {
      return  "";
    }
    return values[hashKey].get(index);
  }
}
