Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05A3583E7
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 14:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhDHM43 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Apr 2021 08:56:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16409 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHM41 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Apr 2021 08:56:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGLnH3hlYzkjPN;
        Thu,  8 Apr 2021 20:54:27 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 20:56:08 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <luojiaxing@huawei.com>
Subject: [PATCH v3 0/2] scsi: pm8001: tiny clean up patches
Date:   Thu, 8 Apr 2021 20:56:31 +0800
Message-ID: <1617886593-36421-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Several error is reported by checkpatch.pl, here are two patches to clean
them up.

---
   v1->v2:
          1. modify AAP1_MEMMAP() to inline function
          2. set flash_command_table and flash_error_table as const
   v2->v3:
	  1. use lower case names for AAP1_MEMMAP
---
Luo Jiaxing (2):
  scsi: pm8001: clean up for white space
  scsi: pm8001: clean up for open brace

 drivers/scsi/pm8001/pm8001_ctl.c | 26 +++++++++++---------------
 drivers/scsi/pm8001/pm8001_ctl.h |  5 +++++
 drivers/scsi/pm8001/pm8001_hwi.c | 14 +++++++-------
 drivers/scsi/pm8001/pm8001_sas.c | 20 ++++++++++----------
 drivers/scsi/pm8001/pm8001_sas.h |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 14 +++++++-------
 6 files changed, 41 insertions(+), 40 deletions(-)

-- 
2.7.4

