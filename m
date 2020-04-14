Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BC1A70DA
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2020 04:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403998AbgDNCNn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Apr 2020 22:13:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2367 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403967AbgDNCNl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 Apr 2020 22:13:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6650673AB8245D8F5B5;
        Tue, 14 Apr 2020 10:13:37 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.252) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 10:13:29 +0800
To:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
Subject: [PATCH] scsi:sg: add sg_remove_request in sg_write
Message-ID: <610618d9-e983-fd56-ed0f-639428343af7@huawei.com>
Date:   Tue, 14 Apr 2020 10:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.252]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

If the __copy_from_user function return failed,
it should call sg_remove_request in sg_write.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
  drivers/scsi/sg.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4e6af59..ff3f532 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -685,8 +685,10 @@ static int get_sg_io_pack_id(int *pack_id, void 
__user *buf, size_t count)
         hp->flags = input_size; /* structure abuse ... */
         hp->pack_id = old_hdr.pack_id;
         hp->usr_ptr = NULL;
-       if (copy_from_user(cmnd, buf, cmd_size))
+       if (copy_from_user(cmnd, buf, cmd_size)) {
+               sg_remove_request(sfp, srp);
                 return -EFAULT;
+       }
         /*
          * SG_DXFER_TO_FROM_DEV is functionally equivalent to 
SG_DXFER_FROM_DEV,
          * but is is possible that the app intended SG_DXFER_TO_DEV, 
because there
--
1.8.3.1

