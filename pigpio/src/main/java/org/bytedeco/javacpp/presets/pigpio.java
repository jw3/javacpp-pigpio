package org.bytedeco.javacpp.presets;

import org.bytedeco.javacpp.annotation.Platform;
import org.bytedeco.javacpp.annotation.Properties;
import org.bytedeco.javacpp.tools.Info;
import org.bytedeco.javacpp.tools.InfoMap;
import org.bytedeco.javacpp.tools.InfoMapper;

/**
 * @author wassj
 */
@Properties(value = @Platform(include = {"pigpio.h"}, link = "pigpio"), target = "org.bytedeco.javacpp.pigpio")
public class pigpio implements InfoMapper {
    public void map(InfoMap infoMap) {
    	infoMap.put(new Info("pthread_t").skip(true));
    }
}
