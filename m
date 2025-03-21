Return-Path: <linux-scsi+bounces-13022-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3892A6BF27
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Mar 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4D2172253
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Mar 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A78227E9B;
	Fri, 21 Mar 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/SK1iO3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262361C5F14
	for <linux-scsi@vger.kernel.org>; Fri, 21 Mar 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573303; cv=none; b=DFRdAWyNy5u9imVteuX2ZWs+tEhmNYpG6FF5DPXzp+beCiEqXbvk0ilFGaW3dOHVWlYh0zgvuaNZgOqhLlplwlFN+FJurhiqqsfVujYKVk0lg2M8aC+u7PG1B26+KD6qj/v5kILmTp8pTbft3WbN3yw2dG/mw8quMHTcB1FctMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573303; c=relaxed/simple;
	bh=qqKZrfLDUAgL2szCwHv4faYCd/UR/f9PAk9LptxdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LtWrGx0yFxPJq9It3lUuEl2CJIxxr7YKWm0f23pa6vOzl38eO6jPMyBtza1juN26lhZbdgtOt3jfhqeYaHJngbeYowNUwkswr7/SSd9kSm3UwYQ7CxTRCbkcu5oJruKoR/WHG1eVKcKfaL4IZot9IZVWcvYd5WgDHUsHMa3K/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/SK1iO3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1596360f8f.0
        for <linux-scsi@vger.kernel.org>; Fri, 21 Mar 2025 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742573299; x=1743178099; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJlE21NtQ+/WCeWlPhYZ2EkXPcDlOOCnP5PIfiKki4o=;
        b=q/SK1iO3IgSfkYaumaXXdK0f0If/lnFGG1Vhb/1XEWAyzkBzaNilcKE/HYyTPeA8ii
         U7eWsyIBE3R27R0pAP6MMl/qigVE9URohJJudIjZ8CIcuHHgbxyxU2qldnzKtdFg2cuX
         yX9s6erfg9mxqghwicfvmKiVUZfUBdD77g5ftWXy0EEFZmNcg2AxUFUU90ScFG0c2WKX
         iXs9GOpiWln1uGNM1pAs5aS036M+RtiZxxLciaTIRdSNnWaeJnkuMomH4SlRBa2ibzih
         7Ib+J9fO9FcBSW8IqVe76cVkVYOkz57wkz1OwxcNlMB0KJ/35nNN+p2kMOEIxzT00L+F
         7MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573299; x=1743178099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJlE21NtQ+/WCeWlPhYZ2EkXPcDlOOCnP5PIfiKki4o=;
        b=jzL/VmKSSXsUtAPFNaZVG0QfL7VulbTDjolC/qYjA8mL/S0BleHtMZmOLtji6f9uIz
         FPvbE1rTgSOl7N+rCBCotubnQl12yORI7J0pPE3Fv9dpiyZJE2XCkrPBRCbxN4oM8xmN
         mN9zUR3YaMprjviQGtvpn36Z3AgxvceCWCxvfBun46h5hkrg4lUlrFN+Fyiu3zghPnuL
         KsKsQm+NLNh46RD5+/0DrKWBOHDEm9NNiXy3rtNPBKdi6oi9Cla7QXj2w8iN55RQS6BP
         f1IhVYqakJL2yJZ9F53DZGld7dRhdn4zFsxbgp5FcNPvq+kpVHifUwBDXJRGJTmx9QNM
         fsOA==
X-Forwarded-Encrypted: i=1; AJvYcCWHuRbc6xJV1w+TV1O7acu0Dggw07CsAcEekLPRs6STeNiNV2C8KGcYHCL9vusY0JvCXPqDOTmhSHpC@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOnqSn9PPxhX7+cF6NHRjMpzl9RbwOPdi8v+X2EuivmUgDSlC
	+goItr9C7vsPMRcDV/NjPT9aIuMjU9f9iLkr6DK+5CtFKrbvzNvFKImSmjCWiHU=
X-Gm-Gg: ASbGncuqiTAtBE5zOGzLXu8mA73Th1G+Vr38/hJw/1K++wiSwxC4sdmUF63Oo9SWmWQ
	3M3OeKmbot+cL5ZbCbeAQHbnav1Pn9Q0rwy3JHP1nwO6yWIFVfLspK1Lavg4vuhF7Xsagi9omJt
	lyahRME0/9QokgI8UZgxo54pG40btT+H1teeRhFuSfdRlUpExCU9IDlw4UrMyzvjsqUxkRVqZyR
	pFGRPWpRlqbNjDHeekAqv+GkuyH1FCASJa1G9V3L6PlKQAV/c7b6vYL2UqDxdljUU3pj4SziXX9
	bvVYdyaF/M/rysdmu0cVqZcY9ttnFsibVVOygP6YKFbs2iDMnO1elfj0E1C2ujaYPA==
X-Google-Smtp-Source: AGHT+IFTq0YgELZyXjjN1VrdTEC3jyzyKHj/fkxB9o1IAbxsWzgbxUBKrT4kCbrIivdgEUdfIERyng==
X-Received: by 2002:a05:6000:1565:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-3997f933816mr3890433f8f.21.1742573299284;
        Fri, 21 Mar 2025 09:08:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99540bsm2705610f8f.2.2025.03.21.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:08:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 21 Mar 2025 17:08:15 +0100
Subject: [PATCH RFC] ufs: delegate the interrupt service routine to a
 threaded irq handler
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-topic-ufs-use-threaded-irq-v1-1-7a55816a4b1d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO6O3WcC/x3MsQqDQAwA0F+RzA2cOW6wq+AHdC0dDi+pWdQmW
 griv/dwfMs7wNmUHe7NAcZfdV3mivbWwDjl+c2opRooUAqRWtyWVUfcxXF3xm0yzoULqn0wxSw
 xCCXqBGqwGov+rvwJj6GH13n+Ae4AWX9xAAAA
X-Change-ID: 20250321-topic-ufs-use-threaded-irq-53af30f2529f
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5604;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qqKZrfLDUAgL2szCwHv4faYCd/UR/f9PAk9LptxdbMY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn3Y7yUu0Foc45zNxh92lwMOcLsLY8ldvYzNdErqF/
 IFXhR2uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ92O8gAKCRB33NvayMhJ0d4TD/
 46nLVEVNe72rd7ntxKZk8prswc2LeIoLBC7j1Y/BjcC9smsnHoqTmhT32gz80EoNNyqEfxHaY90M6v
 CUYrn/2oVD6MlRTj1dpNdCvvliWfiuoLX+Fxy++l8GrC296Ke/+MYBJ1zLFn9jgIxEeVr+Yi8mFU0q
 G3D/ooDq0HH6B4r3aXezNJ8YSvBX/qjvs26eNYj1M5a9wYQgMnzhsJ6C92arDv/dS3pOw6IpRGtgjJ
 g3Z1M/LJkPjKldyevmEaezAIbHNfChpV8NwSnrbBjWpgt2KHyKgrJE2GPfD31VbpY30mp3Zg1Jl0Pd
 0m7xkiHz+LWB9kmws/09JgDFka4+Ffr7oXEo/ZRpyrpDZQLrIZxjqFe15U48kvxzoQfTnMxS6VI/ep
 n58VkjGIG5+46mbF4swurp5qif6Vgt3DmiBmQBa3p2yhcbqEb2jg9C6CdUz3A99OB4sPawEmUO1x8q
 z8k9ghj9g1f+66q6WNFoJ7XelsSyeO/fTtUA1tPm3Fm7JMb5TW5P0fcjAgu4m+QraBbiCMy/3H67my
 yl3lTRYMFXO9Cq3e3nWIVbwaKm2hWBvVkGS9Npb6Fy78+y2avXC3emMwbEX5dMe4cubXaKml2waohs
 JxSpuLrPxofeObKFH5DtnWi9wFZSBHRRVGtr4VQxIDK2RYbXlr483jj//LVA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

On systems with a large number request slots and unavailable MCQ,
the current design of the interrupt handler can delay handling of
other subsystems interrupts causing display artifacts, GPU stalls
or system firmware requests timeouts.

Since the interrupt routine can take quite some time, it's
preferable to move it to a threaded handler and leave the
hard interrupt handler save the status and disable the irq
until processing is finished in the thread.

This fixes all encountered issued when running FIO tests
on the Qualcomm SM8650 platform.

Example of errors reported on a loaded system:
 [drm:dpu_encoder_frame_done_timeout:2706] [dpu error]enc32 frame done timeout
 msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 67.5.20.1: hangcheck detected gpu lockup rb 2!
 msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 67.5.20.1:     completed fence: 74285
 msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 67.5.20.1:     submitted fence: 74286
 Error sending AMC RPMH requests (-110)

Reported bandwidth is not affected on various tests.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/core/ufshcd.c | 43 ++++++++++++++++++++++++++++++++++++-------
 include/ufs/ufshcd.h      |  2 ++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0534390c2a35d0671156d79a4b1981a257d2fbfa..0fa3cb48ce0e39439afb0f6d334b835d9e496387 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6974,7 +6974,7 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
 }
 
 /**
- * ufshcd_intr - Main interrupt service routine
+ * ufshcd_intr - Threaded interrupt service routine
  * @irq: irq number
  * @__hba: pointer to adapter instance
  *
@@ -6982,7 +6982,7 @@ static irqreturn_t ufshcd_sl_intr(struct ufs_hba *hba, u32 intr_status)
  *  IRQ_HANDLED - If interrupt is valid
  *  IRQ_NONE    - If invalid interrupt
  */
-static irqreturn_t ufshcd_intr(int irq, void *__hba)
+static irqreturn_t ufshcd_threaded_intr(int irq, void *__hba)
 {
 	u32 intr_status, enabled_intr_status = 0;
 	irqreturn_t retval = IRQ_NONE;
@@ -6990,8 +6990,6 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 	int retries = hba->nutrs;
 
 	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-	hba->ufs_stats.last_intr_status = intr_status;
-	hba->ufs_stats.last_intr_ts = local_clock();
 
 	/*
 	 * There could be max of hba->nutrs reqs in flight and in worst case
@@ -7000,8 +6998,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 	 * again in a loop until we process all of the reqs before returning.
 	 */
 	while (intr_status && retries--) {
-		enabled_intr_status =
-			intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+		enabled_intr_status = intr_status & hba->intr_en;
 		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
 		if (enabled_intr_status)
 			retval |= ufshcd_sl_intr(hba, enabled_intr_status);
@@ -7020,9 +7017,40 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 		ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
 	}
 
+	ufshcd_writel(hba, hba->intr_en, REG_INTERRUPT_ENABLE);
+
 	return retval;
 }
 
+/**
+ * ufshcd_intr - Main interrupt service routine
+ * @irq: irq number
+ * @__hba: pointer to adapter instance
+ *
+ * Return:
+ *  IRQ_WAKE_THREAD - If interrupt is valid
+ *  IRQ_NONE	    - If invalid interrupt
+ */
+static irqreturn_t ufshcd_intr(int irq, void *__hba)
+{
+	u32 intr_status, enabled_intr_status = 0;
+	irqreturn_t retval = IRQ_NONE;
+	struct ufs_hba *hba = __hba;
+	int retries = hba->nutrs;
+
+	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
+	hba->ufs_stats.last_intr_status = intr_status;
+	hba->ufs_stats.last_intr_ts = local_clock();
+
+	if (unlikely(!intr_status))
+		return IRQ_NONE;
+
+	hba->intr_en = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+	ufshcd_writel(hba, 0, REG_INTERRUPT_ENABLE);
+
+	return IRQ_WAKE_THREAD;
+}
+
 static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
 {
 	int err = 0;
@@ -10581,7 +10609,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
 	/* IRQ registration */
-	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);
+	err = devm_request_threaded_irq(dev, irq, ufshcd_intr, ufshcd_threaded_intr,
+					IRQF_SHARED, UFSHCD, hba);
 	if (err) {
 		dev_err(hba->dev, "request irq failed\n");
 		goto out_disable;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index e3909cc691b2a854a270279901edacaa5c5120d6..03a7216b89fd63c297479422d1213e497ce85d8e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -893,6 +893,7 @@ enum ufshcd_mcq_opr {
  * @ufshcd_state: UFSHCD state
  * @eh_flags: Error handling flags
  * @intr_mask: Interrupt Mask Bits
+ * @intr_en: Saved Interrupt Enable Bits
  * @ee_ctrl_mask: Exception event control mask
  * @ee_drv_mask: Exception event mask for driver
  * @ee_usr_mask: Exception event mask for user (set via debugfs)
@@ -1040,6 +1041,7 @@ struct ufs_hba {
 	enum ufshcd_state ufshcd_state;
 	u32 eh_flags;
 	u32 intr_mask;
+	u32 intr_en;
 	u16 ee_ctrl_mask;
 	u16 ee_drv_mask;
 	u16 ee_usr_mask;

---
base-commit: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
change-id: 20250321-topic-ufs-use-threaded-irq-53af30f2529f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


