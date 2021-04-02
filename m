Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901635282B
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Apr 2021 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhDBJIc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Apr 2021 05:08:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15591 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhDBJI0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Apr 2021 05:08:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZ0l0VWMz1BG8P;
        Fri,  2 Apr 2021 17:06:15 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:08:13 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <luojiaxing@huawei.com>
Subject: [PATCH v1 2/2] scsi: pm8001: clean up for open brace
Date:   Fri, 2 Apr 2021 17:08:42 +0800
Message-ID: <1617354522-17113-3-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617354522-17113-1-git-send-email-luojiaxing@huawei.com>
References: <1617354522-17113-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There are few error about open brace is reported by checkpatch.pl:

ERROR: that open brace { should be on the previous line
+static struct error_fw flash_error_table[] =
+{

So fix them all.

Signed-off-by: Jianqin Xie <xiejianqin@hisilicon.com>
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index ffb4387..8802fe4 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -647,8 +647,7 @@ struct flash_command {
      int     code;
 };
 
-static struct flash_command flash_command_table[] =
-{
+static struct flash_command flash_command_table[] = {
      {"set_nvmd",    FLASH_CMD_SET_NVMD},
      {"update",      FLASH_CMD_UPDATE},
      {"",            FLASH_CMD_NONE} /* Last entry should be NULL. */
@@ -659,8 +658,7 @@ struct error_fw {
      int     err_code;
 };
 
-static struct error_fw flash_error_table[] =
-{
+static struct error_fw flash_error_table[] = {
      {"Failed to open fw image file",	FAIL_OPEN_BIOS_FILE},
      {"image header mismatch",		FLASH_UPDATE_HDR_ERR},
      {"image offset mismatch",		FLASH_UPDATE_OFFSET_ERR},
-- 
2.7.4

