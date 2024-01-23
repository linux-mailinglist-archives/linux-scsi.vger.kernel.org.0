Return-Path: <linux-scsi+bounces-1843-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A6839957
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jan 2024 20:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D303C293AE4
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jan 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8D811EE;
	Tue, 23 Jan 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbLRBQVR"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995296A005
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jan 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037265; cv=none; b=Gz02GsirNHTnkCFdtHJ3/E9EXhKBQVjf6P/5DvaWKsWE/fJmRhR35eErRa/99LbfkWZ6pEK/75G9Ftj7YlfmET1sJ7vFXc7rjJ2hfBAbQB6MEdWayzUfu+labv8NgTxOmuTRk1gav0RdCGGp2S4Guz55/e/pR/zJdHg5PPnm6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037265; c=relaxed/simple;
	bh=XyTcwd8qXE/hKl/HKpN6+Q+TlUcZa83KF6IodAsDa/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n6s/LF7pZajIAP55qwtaQBk4FkM32HuWnqSCMXHTbBeza0UL7xQAtlmE/EiQOwlDvxM5EvUNCXoZQBCOb5YQesVO2TJTKUzgywoiVoLSlEt1AMD3Gzk9t/GQkrSAw8th549KWPwx08LSs1Qnq9rLOeean9raHkzAa3ai973IanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbLRBQVR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706037262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JX1C39DLRiXRo9KmPAPcoOAD8i9NqnqwxEQEJ9FubBk=;
	b=VbLRBQVRUNuhy+io31f+AcFKsZLpKMtn070olk06CIfa6kILPZezn6GefJl3GAganqk7F+
	z6zFZXCNMBdHlkjTHozXTZLCBufYWirZZnFV0G3S+v0/Mf1MKgO8LXtiYkPjrOXIL4httn
	LG3pM3qYwrdCOaJlhSgLZr12G2zAqbw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-OVJEIVZPOZGmBFHbVn4D0A-1; Tue, 23 Jan 2024 14:14:20 -0500
X-MC-Unique: OVJEIVZPOZGmBFHbVn4D0A-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46734fa034cso1197068137.2
        for <linux-scsi@vger.kernel.org>; Tue, 23 Jan 2024 11:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037260; x=1706642060;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX1C39DLRiXRo9KmPAPcoOAD8i9NqnqwxEQEJ9FubBk=;
        b=QjYIsL2EA9QyVwKFNf3P2db53T5RegATP7SW7/sn3TqK9c5+LfsTZO+czUxg5gE87i
         lL/VwqnL1LJepYnPQKOM7cAvbcUHt16/A1VaSHo4RPYxbr2AqXfiHtOHAf8IKHPvxRoh
         DiTEXI1ZO7k+CBwkHGVFOCcwvH2rCxfJM3DpTxCNNMe6hnA/BtKusTLPiSu7rSRBO0wA
         tnuC00oCyGYFDmuEh8PT83Dq+c6NNzyMiWHeyqUtqFUP0VO2+6+1q2GpRR4VjrTH/Yva
         wFEwg+DLe2JdinVyJJI2neRGT63AahMk8t7wDdY2Upd9+CsTitcWXrDADy/7Mp/pYIyY
         q5Rg==
X-Gm-Message-State: AOJu0YzvO/DZ5KG672vmkTK1HRjksCTiFwZ45pfbHaZUc63pbahOT0bX
	OwF9oKCelEEXGH3f/L/OzjFmZDpBQiX1/gtQHmK7sWCoIuA3ouDXVOMVLcnUWmFLjAu6dc+foTa
	XsXrj+GwLnwB5cUGiTr6061S8d9S5ZIMv8yy70aBTrpQ4ixfsWRKB/f3RYgI=
X-Received: by 2002:a05:6102:504:b0:469:877d:fc1a with SMTP id l4-20020a056102050400b00469877dfc1amr3831540vsa.8.1706037260324;
        Tue, 23 Jan 2024 11:14:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcPBUMVwlS4nMBzDdAWf4eFzF3isPk56IUM4Qu5TPTFe0QdBgOX49eKPlHyED9Kzt5PBx5MQ==
X-Received: by 2002:a05:6102:504:b0:469:877d:fc1a with SMTP id l4-20020a056102050400b00469877dfc1amr3831528vsa.8.1706037259988;
        Tue, 23 Jan 2024 11:14:19 -0800 (PST)
Received: from [192.168.171.162] ([2600:380:6a3c:801d:216a:a904:5575:54a5])
        by smtp.gmail.com with ESMTPSA id oh6-20020a056214438600b00685754458c9sm3616658qvb.115.2024.01.23.11.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:14:19 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Tue, 23 Jan 2024 13:13:36 -0600
Subject: [PATCH] scsi: ufs: qcom: Clarify comments about the initial
 phy_gear
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>
X-B4-Tracking: v=1; b=H4sIAN8PsGUC/x3MQQqAIBBA0avErBtQM4OuEi3ExppFFk5FEN09a
 fkW/z8glJkE+uqBTBcLb6lA1xWExaeZkKdiMMpYpU2DZxTMxIkPDNu6UjoEdRes9dEZ12oo5Z4
 p8v1fh/F9P0uIne1lAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, echanude@redhat.com
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

The comments that currently are within the hw_ver < 4 conditional
are misleading. They really apply to various branches of the
conditionals there and incorrectly state that the phy_gear value
can increase.

Right now the logic is to:

    * Default to max supported gear for phy_gear
    * Set phy_gear to minimum value if version < 4 since those versions
      only support one PHY init sequence (and therefore don't need reinit)
    * Set phy_gear to the optimal value if the device version is already
      populated in the controller registers on boot

Let's move some of the comment to outside the if statement and clean up
the bit left about switching to a higher gear on reinit. This way the
comment more accurately reflects the logic.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
This is a minor comment cleanup inspired by my mistaken understanding of
the flow over at [0]

[0] https://lore.kernel.org/linux-arm-msm/20240123143615.GD19029@thinkpad/
---
 drivers/ufs/host/ufs-qcom.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 39eef470f8fa..d9ec2dfbbda4 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -843,15 +843,20 @@ static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
 	struct ufs_host_params *host_params = &host->host_params;
 	u32 val, dev_major;
 
+	/*
+	 * Default to powering up the PHY to the max gear possible, which is
+	 * backwards compatible with lower gears but not optimal from
+	 * a power usage point of view. After device negotiation, if the
+	 * gear is lower a reinit will be performed to program the PHY
+	 * to the ideal gear for this combo of controller and device.
+	 */
 	host->phy_gear = host_params->hs_tx_gear;
 
 	if (host->hw_ver.major < 0x4) {
 		/*
-		 * For controllers whose major HW version is < 4, power up the
-		 * PHY using minimum supported gear (UFS_HS_G2). Switching to
-		 * max gear will be performed during reinit if supported.
-		 * For newer controllers, whose major HW version is >= 4, power
-		 * up the PHY using max supported gear.
+		 * These controllers only have one PHY init sequence,
+		 * let's power up the PHY using that (the minimum supported
+		 * gear, UFS_HS_G2).
 		 */
 		host->phy_gear = UFS_HS_G2;
 	} else if (host->hw_ver.major >= 0x5) {

---
base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
change-id: 20240123-ufs-reinit-comments-17c44af62651

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


