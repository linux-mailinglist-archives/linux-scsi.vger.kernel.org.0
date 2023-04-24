Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70D6E9738
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Apr 2023 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDTOel (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Apr 2023 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDTOek (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Apr 2023 10:34:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF31A7
        for <linux-scsi@vger.kernel.org>; Thu, 20 Apr 2023 07:34:32 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q2Kq845rHzKxTj;
        Thu, 20 Apr 2023 22:31:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 22:34:29 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2 0/3] scsi: libsas: remove empty branches and code simplification
Date:   Thu, 20 Apr 2023 22:33:36 +0800
Message-ID: <20230420143339.2769414-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Three patches to remove two empty branches and a little code
simplification.

v1->v2:
  1. Add blank line after declaration in sas_eeds_valid().
  2. Drop the inner-most and outter-most parenthesis in sas_eeds_valid().
  3. Break the long line in the declaration of sas_check_phy_topology().
  4. Move "else if" to the same line after "}".

Jason Yan (3):
  scsi: libsas: Simplify sas_check_eeds()
  scsi: libsas: Remove an empty branch in sas_check_parent_topology()
  scsi: libsas: Simplify sas_check_parent_topology()

 drivers/scsi/libsas/sas_expander.c | 135 ++++++++++++++++-------------
 1 file changed, 73 insertions(+), 62 deletions(-)

-- 
2.31.1

