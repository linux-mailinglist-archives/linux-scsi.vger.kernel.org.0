Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABD4C9D7F
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 06:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiCBFhZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 00:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiCBFhR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 00:37:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43203B1884
        for <linux-scsi@vger.kernel.org>; Tue,  1 Mar 2022 21:36:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222jYNC010945;
        Wed, 2 Mar 2022 05:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=e4MgRVQO2C71j0KKI4qbziKW4PfAOGxxVRAmI4+mhbw=;
 b=eT6Rh2c4r2TM/a84Jie8YpTMy6BLi42F89RTq/2oteFs9lOYJaeBScI7tYs3VOYR2wLd
 OZgmQPBD2TGaf3blqvIZK5geM2QV1HNe6wtHytY7Wb7JEW/p3PdU+1WqIzRB0gf7UM4l
 TdXBjaLa9TUn/rznV+/lRVOe1jMjsJl+Zjk6Zj2e/sLk1i9HWmkITHDuPY+UrL/bXMs8
 Av5pUgAZNkoSRyTBTAKdVI9EMZsWoqwRzv1+auEZ2Kd4LKWtQSBoo2aIxxEV56YMFpLd
 XS8W0uckZWOj00tm9CvpF4BwsWG9rC0O+BC/t7x8MDJOiZDfPmkf09zExO3P02z9A+y9 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bvwcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:36:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225IuqD175937;
        Wed, 2 Mar 2022 05:36:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3efc15vakx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:36:33 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225aRZr014395;
        Wed, 2 Mar 2022 05:36:33 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3efc15vaeg-13;
        Wed, 02 Mar 2022 05:36:33 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 12/14] scsi: sd: sd_read_cpr() requires VPD pages
Date:   Wed,  2 Mar 2022 00:35:57 -0500
Message-Id: <20220302053559.32147-13-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302053559.32147-1-martin.petersen@oracle.com>
References: <20220302053559.32147-1-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M8wgqdDm62CkHmUwTG1nXTjMXyVYjZ81
X-Proofpoint-ORIG-GUID: M8wgqdDm62CkHmUwTG1nXTjMXyVYjZ81
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As such it should be called inside the scsi_device_supports_vpd()
conditional.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Fixes: e815d36548f0 ("scsi: sd: add concurrent positioning ranges support")
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2c2e86738578..9d6b2205339d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3396,6 +3396,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 			sd_read_block_limits(sdkp);
 			sd_read_block_characteristics(sdkp);
 			sd_zbc_read_zones(sdkp, buffer);
+			sd_read_cpr(sdkp);
 		}
 
 		sd_print_capacity(sdkp, old_capacity);
@@ -3405,7 +3406,6 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_read_app_tag_own(sdkp, buffer);
 		sd_read_write_same(sdkp, buffer);
 		sd_read_security(sdkp, buffer);
-		sd_read_cpr(sdkp);
 		sd_config_write_same(sdkp);
 		sd_config_discard(sdkp, SD_LBP_DEFAULT);
 		sd_config_write_zeroes(sdkp, SD_ZERO_DEFAULT);
-- 
2.32.0

