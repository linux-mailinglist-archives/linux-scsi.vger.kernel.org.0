Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3329A2FBCFE
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Jan 2021 17:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbhASQyK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Jan 2021 11:54:10 -0500
Received: from m12-15.163.com ([220.181.12.15]:57949 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389631AbhASQx4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 Jan 2021 11:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=0U+pRaymnbrvdWHk/1
        qG3LeFSFiwut3uSGl7JwDYbSk=; b=jUowwnWQtrrXZDWheB3aV/2xyj4pLVhArt
        vh7u+ywDzl5GbizMOMjxDe9LvPtRGqshlOvEaQIbzqOLALSAyFRVBDPNap59uL+/
        pOx+OMZdvhJ/lb26B7iPcDLBUnksUCEJJXR7fkGDbefAA5vW0g0xBgzIIxQZiY0R
        d9sIBJYoY=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp11 (Coremail) with SMTP id D8CowADHzH2J0QZg3sXTAA--.28998S4;
        Tue, 19 Jan 2021 20:33:17 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] bsg: free the request before return error code
Date:   Tue, 19 Jan 2021 04:33:11 -0800
Message-Id: <20210119123311.108137-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowADHzH2J0QZg3sXTAA--.28998S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDCFW5Gr1UJFWrAryDAwb_yoWxtFb_GF
        yUKFs7JrZ5Cr45ursFva45t3WIkF1UGF4Iyw18tF9Fq345JasrJw1Ivwn8XF9xWFWUW3sx
        G3WxX34fAFnayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU57CztUUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZA0fclQHMCpPDgAAsM
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Free the request rq before returning error code.

Fixes: 972248e9111e ("scsi: bsg-lib: handle bidi requests without block layer help")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 block/bsg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bsg.c b/block/bsg.c
index d7bae94b64d9..3d78e843a83f 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -157,8 +157,10 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 		return PTR_ERR(rq);
 
 	ret = q->bsg_dev.ops->fill_hdr(rq, &hdr, mode);
-	if (ret)
+	if (ret) {
+		blk_put_request(rq);
 		return ret;
+	}
 
 	rq->timeout = msecs_to_jiffies(hdr.timeout);
 	if (!rq->timeout)
-- 
2.17.1


