Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8B356904
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Apr 2021 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbhDGKHg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Apr 2021 06:07:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbhDGKHb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Apr 2021 06:07:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFg3l29yrzPnXG;
        Wed,  7 Apr 2021 18:04:35 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 18:07:13 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <luojiaxing@huawei.com>
Subject: [PATCH v2 0/2] scsi: pm8001: tiny clean up patches
Date:   Wed, 7 Apr 2021 18:07:37 +0800
Message-ID: <1617790059-43125-1-git-send-email-luojiaxing@huawei.com>
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

