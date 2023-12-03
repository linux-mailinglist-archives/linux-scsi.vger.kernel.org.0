Return-Path: <linux-scsi+bounces-472-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF40D802647
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 19:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1491C20748
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854717993
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 18:33:57 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5467FE7;
	Sun,  3 Dec 2023 10:14:07 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [60.186.191.128])
	by mail-app4 (Coremail) with SMTP id cS_KCgCHjTVnxWxlastEAA--.50948S2;
	Mon, 04 Dec 2023 02:14:00 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Giridhar Malavali <gmalavali@marvell.com>,
	Himanshu Madhani <hmadhani@marvell.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: fix a memleak in qla2x00_mem_alloc
Date: Mon,  4 Dec 2023 02:13:42 +0800
Message-Id: <20231203181342.3289136-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgCHjTVnxWxlastEAA--.50948S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1kCry5XF1xGrW7Jr1DWrg_yoWkWrg_ua
	1UXFyxuw1qgr4xJw18JrySy39Fv3Wqqr1vkFsYqry3JrW5uw18Wr15XayrZa1fXw4ayFZ8
	uw47XrW5ZryUtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When the dsd allocated in the for loop by kzalloc fails, it should gc
all the resources allocated before, instead of just return a -ENOMEM.

According to the error-handling behavior of ha->dif_bundl_pool, the
dsd's failure should free every resources after fail_dif_bundl_dma_pool,
together with ha->dif_bundl_pool itself. So the error-handling should
goes to label fail_dma_pool.

Fixes: 50b812755e97 ("scsi: qla2xxx: Fix DMA error when the DIF sg buffer crosses 4GB boundary")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 50db08265c51..bdd66f9e8850 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4252,7 +4252,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 					ql_dbg_pci(ql_dbg_init, ha->pdev,
 					    0xe0ee, "%s: failed alloc dsd\n",
 					    __func__);
-					return -ENOMEM;
+					goto fail_dma_pool;
 				}
 				ha->dif_bundle_kallocs++;
 
-- 
2.34.1


