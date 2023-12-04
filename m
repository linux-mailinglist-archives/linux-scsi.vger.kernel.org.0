Return-Path: <linux-scsi+bounces-487-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209988030BE
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 11:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84421F20EDE
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6AA22313
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 10:42:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
X-Greylist: delayed 660 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 01:05:49 PST
Received: from aliyun-sdnproxy-4.icoremail.net (aliyun-cloud.icoremail.net [47.90.73.12])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 66A6ACD
	for <linux-scsi@vger.kernel.org>; Mon,  4 Dec 2023 01:05:49 -0800 (PST)
Received: from localhost.localdomain (unknown [10.190.71.14])
	by mail-app4 (Coremail) with SMTP id cS_KCgAnLzc_km1la3hIAA--.18836S4;
	Mon, 04 Dec 2023 16:48:07 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shu Wang <shuwang@redhat.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: fix a use-after-free in megasas_alloc_cmdlist_fusion
Date: Mon,  4 Dec 2023 16:47:27 +0800
Message-Id: <20231204084727.23114-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgAnLzc_km1la3hIAA--.18836S4
X-Coremail-Antispam: 1UD129KBjvdXoWrur1ftryDuF1xGFyUJFWkWFg_yoWkKrc_ur
	4FyF9Fvry2qrs3A3yxCrZYkrWIyr1jv3ykKr4Sgr4Skwn7Jr9rG3ZrKrn2vFZrG3yqkFy3
	K3W5Jr4xCwn7XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgITBmVsUQg1UgAAsi
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

When kzalloc() fails, megasas_alloc_cmdlist_fusion will free
fusion->cmd_list and its array elements. However, the caller
megasas_alloc_cmds_fusion() will call megasas_free_cmds_fusion()
on the same failure, which tries to free fusion->cmd_list again
and leads to a use-after-free. Fix this by setting
fusion->cmd_list to NULL after kfree().

Fixes: 70c54e210ee9 ("scsi: megaraid_sas: fix memleak in megasas_alloc_cmdlist_fusion")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index c60014e07b44..a47735e64624 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -613,6 +613,7 @@ megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
 			for (j = 0; j < i; j++)
 				kfree(fusion->cmd_list[j]);
 			kfree(fusion->cmd_list);
+			fusion->cmd_list = NULL;
 			dev_err(&instance->pdev->dev,
 				"Failed from %s %d\n",  __func__, __LINE__);
 			return -ENOMEM;
-- 
2.17.1


