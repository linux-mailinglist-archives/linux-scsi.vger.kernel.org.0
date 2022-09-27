Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B825EB887
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Sep 2022 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiI0DQz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Sep 2022 23:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiI0DQB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Sep 2022 23:16:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EB58514;
        Mon, 26 Sep 2022 20:15:37 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mc4Qc5wnMz1P6gX;
        Tue, 27 Sep 2022 11:11:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 11:15:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 0/8] scsi: libsas: sas address comparison refactor
Date:   Tue, 27 Sep 2022 11:25:57 +0800
Message-ID: <20220927032605.78103-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sas address conversion and comparison is widely used in libsas and
drivers. However they are all opencoded and to avoid the line spill over
80 columns, are mostly split into multi-lines.

To make the code easier to read, introduce some helpers with clearer
semantics and replace the opencoded segments with them.

v3->v4:
  Fix comparison typo.
  Fix test condition error in sas_check_parent_topology() of patch #6.

v2->v3:
  Rename sas_phy_addr_same() to sas_phy_addr_match().
  Rearrange patches, move patch #6 to #1 and directly use the helper
  	sas_phy_match_dev_addr() in sas_find_attached_phy().
  Add some review tags from Jack Wang.

v1->v2:
  First factor out sas_find_attached_phy() and replace LLDDs's code
  	with it.
  Remove three too simple helpers.
  Rename the helpers with 'sas_' prefix.

Jason Yan (8):
  scsi: libsas: introduce sas address comparison helpers
  scsi: libsas: introduce sas_find_attached_phy() helper
  scsi: pm8001: use sas_find_attached_phy() instead of open coded
  scsi: mvsas: use sas_find_attached_phy() instead of open coded
  scsi: hisi_sas: use sas_find_attathed_phy() instead of open coded
  scsi: libsas: use sas_phy_match_dev_addr() instead of open coded
  scsi: libsas: use sas_phy_addr_match() instead of open coded
  scsi: libsas: use sas_phy_match_port_addr() instead of open coded

 drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ++------
 drivers/scsi/libsas/sas_expander.c    | 40 ++++++++++++++++-----------
 drivers/scsi/libsas/sas_internal.h    | 17 ++++++++++++
 drivers/scsi/mvsas/mv_sas.c           | 15 +++-------
 drivers/scsi/pm8001/pm8001_sas.c      | 16 ++++-------
 include/scsi/libsas.h                 |  2 ++
 6 files changed, 54 insertions(+), 48 deletions(-)

-- 
2.31.1

