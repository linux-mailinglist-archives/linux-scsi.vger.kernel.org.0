Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2F995A8
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfHVN6h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 09:58:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731965AbfHVN6g (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 09:58:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0ACE8C622FB20B12A214;
        Thu, 22 Aug 2019 21:58:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 21:58:14 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <hare@suse.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 0/3] scsi: aic7xxx: remove some set but not used variables
Date:   Thu, 22 Aug 2019 22:04:42 +0800
Message-ID: <1566482685-117305-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

zhengbin (3):
  scsi: aic7xxx: remove set but not used variables
    'ahd','paused','wait','saved_scsiid'
  scsi: aic7xxx: remove set but not used variables 'ahc','targ'
  scsi: aic7xxx: remove set but not used variables 'tinfo','lqistat2'

 drivers/scsi/aic7xxx/aic79xx_core.c | 15 ++-------------
 drivers/scsi/aic7xxx/aic79xx_osm.c  |  9 ---------
 drivers/scsi/aic7xxx/aic7xxx_osm.c  |  6 ------
 3 files changed, 2 insertions(+), 28 deletions(-)

--
2.7.4

