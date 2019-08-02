package org.timesheet.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class QueryConstants {
    private  final Logger logger = LoggerFactory.getLogger(QueryConstants.class);

    public static final String QUESTIONMARK = "?";

    public static final String PAGE = "page";
    public static final String SIZE = "size";
    public static final String SORT_BY = "sortBy";
    public static final String SORT_ORDER = "sortOrder";

    public static final String ID = "id"; // is constant because it's used for the controller mapping

    private QueryConstants() {
        logger.info(" ==== QueryConstants ======= construct ====== ");
  
        throw new AssertionError();
    }

    //

}
