Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496E760608
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jul 2023 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGYCvQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jul 2023 22:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGYCvO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jul 2023 22:51:14 -0400
X-Greylist: delayed 154257 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 19:50:43 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FAF11BF5;
        Mon, 24 Jul 2023 19:50:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [125.119.240.231])
        by mail-app2 (Coremail) with SMTP id by_KCgC3v4tZN79kPYeCCg--.10631S4;
        Tue, 25 Jul 2023 10:45:45 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        vikas.chaudhary@qlogic.com, JBottomley@Parallels.com,
        mchan@broadcom.com, benli@broadcom.com, ogerlitz@voltaire.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1 2/2] scsi: iscsi: Add strlen check in iscsi_if_set_{host}_param
Date:   Tue, 25 Jul 2023 10:45:45 +0800
Message-Id: <20230725024545.428519-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgC3v4tZN79kPYeCCg--.10631S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWUGFy5Cw45WFyDtry7Wrg_yoW5GFyrpF
        WrW345A3yUJrZ2kwnrXr4rKrWSkFs3XrWDtFW8t3s8ArZ8KFy5Ka9rKw4Y9FyUArs8Xw1Y
        gayUt3W5Wr12krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The function iscsi_if_set_param and iscsi_if_set_host_param converts
nlattr payload to type char* and then call C string handling functions
like sscanf and kstrdup.

  char *data = (char*)ev + sizeof(*ev);
  ...
  sscanf(data, "%d", &value);

However, since the nlattr is provided by the user-space program and
the nlmsg skb is allocated with GFP_KERNEL instead of GFP_ZERO flag
(see netlink_alloc_large_skb in netlink_sendmsg), the dirty data
remained in the heap can cause OOB read for those string handling
functions.

By investigating how the bug is introduced, we find it is really
interesting as the old version parsing code starting from commit
fd7255f51a13 ("[SCSI] iscsi: add sysfs attrs for uspace sync up")
treated the nlattr as integer bytes instead of string and had length
check in iscsi_copy_param.

  if (ev->u.set_param.len != sizeof(uint32_t))
    BUG();

But, since the commit a54a52caad4b ("[SCSI] iscsi: fixup set/get param
functions"), code treated the nlattr as C string while forggeting to add
any strlen checks, hence leave the possibility of OOB.

This patch fixes the potential OOB by adding the strlen check before
accessing the buf. If the data passes this check, all low-level
set_param handlers can safely treat this buf as legal C string.

Fixes: fd7255f51a13 ("[SCSI] iscsi: add sysfs attrs for uspace sync up")
Fixes: 1d9bf13a9cf9 ("[SCSI] iscsi class: add iscsi host set param event")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1 -> V2: resend with correct CC list

 drivers/scsi/scsi_transport_iscsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 62b24f1c0232..8ade01da3045 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3030,6 +3030,10 @@ iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev, u
 	if (!conn || !session)
 		return -EINVAL;
 
+	/* data will be regarded as NULL-ended string, do length check */
+	if (strlen(data) > ev->u.set_param.len)
+		return -EINVAL;
+
 	switch (ev->u.set_param.param) {
 	case ISCSI_PARAM_SESS_RECOVERY_TMO:
 		sscanf(data, "%d", &value);
@@ -3203,6 +3207,10 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 		return -ENODEV;
 	}
 
+	/* see similar check in iscsi_if_set_param() */
+	if (strlen(data) > ev->u.set_host_param.len)
+		return -EINVAL;
+
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
 	scsi_host_put(shost);
-- 
2.17.1

