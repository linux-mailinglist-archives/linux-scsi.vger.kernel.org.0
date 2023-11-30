Return-Path: <linux-scsi+bounces-380-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB757FFD13
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 21:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FB4280A47
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC035647A
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqArQt8j"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C640010E6
	for <linux-scsi@vger.kernel.org>; Thu, 30 Nov 2023 12:41:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2856437b584so1237810a91.3
        for <linux-scsi@vger.kernel.org>; Thu, 30 Nov 2023 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701376863; x=1701981663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HToncW+LE9zv/92mmvcSPtZdBZoVOlwPwlFSkGOjsOE=;
        b=KqArQt8j49LztbJuDs5bQg1WD9YUnXMeVk0KOYid8RZIg6X6p4jcsEchBBTG3QAesG
         z9y4vA9ABXoM+z9dKcvvUanSKAmaYBffW6Draer049LSacHsXbv/fPim+AeoAaiFYMYI
         XSd44EzQlb1ImNNqD+MLm0i78ErsbWDZiSL+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376863; x=1701981663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HToncW+LE9zv/92mmvcSPtZdBZoVOlwPwlFSkGOjsOE=;
        b=kbWAWxrmkNJXiX45YTEEiyZcFvNuu+wnI+WX631YLZ1yjnzYnS+zIlGJ02Opu0pcya
         Bcruvudmirm8kayJaGdSClLTSBlZTT2bNLrOpWJ2Bo1Ghgc+M1Ge8BJm5XU1sPYaxahH
         KYDOZB1nrzyi/8WAWcgmM7JfVjZEFeerUn4QrA2FF0AhoUfrNcXnEMmp8t6EXrM6P967
         0vgmb45wTZWWsOE1hj/DMhKW35OZnj3GnmDzoAKvx1rD57lm3HDlZcbXjiq9QaP40spV
         a7IRHGqbF1aizT5zjH3cnl2n0RC5yI1+EBKSFqzoRwfTGQPLQX+A5lVftnefjkkqTbOe
         D4Fg==
X-Gm-Message-State: AOJu0Yycp7LRxameNXI46OLgpTV9lEyaf7j/pNGqkMbt2dNKif/BVAo3
	ZyxOKI3TbTqtyKgQTeDHLSPyYA==
X-Google-Smtp-Source: AGHT+IHT8r+vIHM19r9/cmghSmd07BQmXDud2a0ZuvaCvL7MyTKzM4U/BnENyZhul9YQdIGyG7UUiA==
X-Received: by 2002:a17:90a:357:b0:280:11e2:12d6 with SMTP id 23-20020a17090a035700b0028011e212d6mr23564604pjf.45.1701376862994;
        Thu, 30 Nov 2023 12:41:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090ad70100b002802d9d4e96sm3643102pju.54.2023.11.30.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:41:02 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Steffen Maier <maier@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] scsi: zfcp: Replace strlcpy() with strscpy()
Date: Thu, 30 Nov 2023 12:41:00 -0800
Message-Id: <20231130204056.it.978-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4T81lpDgaAOBeJi0R1mIeRgW4gBp3WUx30Gv6j9ztlg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPNc3DGEDg6n6R2jxBMkNqrOja1osTULCasaX
 UZxQBioA02JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjzXAAKCRCJcvTf3G3A
 Jt5HD/9yXU4FXoT7iWh3EJhfuA3Y8HjktI8X29ZdPW0aN9g75IBIIy3FgqByl/7RW4rsCf5IHqJ
 1aRTj37ijdQRxNQujB1di6Z5d4ENubNma2Mxr5wzCo8z/hpZT2jIPljlx3QkPgzrXLDYh2wMkqQ
 g69yTCJNXDdqug8Fva4Kd43e0vKoS/hYP7ZwpD5KLe8TjFTpvsO5mtx/6BmfOPjnT3hwE+j4yPt
 eaqmeLip+SqCsS2/8GAACN4LnGN80Nf5qBo2IxfcyqVb1GqVV7RJUUXH3O2XYzztawyWNwa9fbP
 lZ29Kv/CohmuVG0IJ16NnPQpampEdGS+3pruhhAN5bLYDDXoMKLyOKCzPvr+yi+KkvNQ8b2cnLy
 hHr55lbbbJzexMLk3qSUwrPXoZz3tXqJfKuU+QjiAbepT4atZ2iNNuJlpU+yEKy0joztLRe7siI
 AigbbIEwoO0HFTZ5XxhuSnjD3l0KUvs4a/MzQX6bPW/hlSDlgWgWPwASipbPWg4FsABC8skhV0d
 ytiReTa8uhR3GObcq6FbtR4lPUFRnrQAGEO5n+cFP7GQoCiDIXzCMbLC5llgbhie36UiI2pAyaD
 4FYFS6Gdgpz9+oTBiO9wC+OZczjqPLM6wDULZbIrqimHDLDi4wzoTfXXWj+IgukvhJRQYRIfY1A
 12tH4Xb UQs6sKKg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Overflow should be impossible here, but actually check for buffer sizes
being identical with BUILD_BUG_ON(), and include a run-time check as
well.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>
Cc: Benjamin Block <bblock@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2:
 - add BUILD_BUG_ON (bblock)
 - CC SCSI maintainers (bblock)
 v1: https://lore.kernel.org/all/20231116191435.work.581-kees@kernel.org/
---
 drivers/s390/scsi/zfcp_fc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 4f0d0e55f0d4..d6516ab00437 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -900,8 +900,19 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
 	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
 			   FC_SYMBOLIC_NAME_SIZE);
 	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
-	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
-		      FC_SYMBOLIC_NAME_SIZE);
+
+	BUILD_BUG_ON(sizeof(rspn_req->name) !=
+			sizeof(fc_host_symbolic_name(shost)));
+	BUILD_BUG_ON(sizeof(rspn_req->name) !=
+			type_max(typeof(rspn_req->rspn.fr_name_len)) + 1);
+	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
+		      sizeof(rspn_req->name));
+	/*
+	 * It should be impossible for this to truncate (see BUILD_BUG_ON()
+	 * above), but be robust anyway.
+	 */
+	if (WARN_ON(len < 0))
+		len = sizeof(rspn_req->name) - 1;
 	rspn_req->rspn.fr_name_len = len;
 
 	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));
-- 
2.34.1


