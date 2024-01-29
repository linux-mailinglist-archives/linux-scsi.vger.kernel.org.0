Return-Path: <linux-scsi+bounces-1941-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24FA83FF4F
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jan 2024 08:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F181C23653
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jan 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C219524B1;
	Mon, 29 Jan 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7uXVklI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7051C4E
	for <linux-scsi@vger.kernel.org>; Mon, 29 Jan 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514751; cv=none; b=Ql5jiKdAsayOtr+nUmpy6QSG+zyXu7e7Vll0w0nUKtto1xLqBbdVX2vwXmJktl2Mtt5PvX8/j0SAzLh4yyvDJsXOCc2a9Wkv8dr3Wo0XqqiBmVjpV5YDjt87oymVK4LcnI5sR5eHboH3pSKBIrvEdLo1l6NIu7bP31F/eQth+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514751; c=relaxed/simple;
	bh=tTQT9Ku7RM1FLsAH3vWmzrAWVFN9wIhJQ1xDZJNKp4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+reR/svefSAclpb2qQA3Aqjy6uBZFvAA0OlBX95CtCUJOzSyMVNGJP4mcJug54DkPjhx1sgpjJhUaShdMgD/scNb5GhqkVeRy+HnDURa+pHXqN1vnKILptlGEaTrgE54ChOm5EkyaSLEtH4tmlAy7udDtGu3Kq9S4WuXGGGCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7uXVklI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc2a78829so754451b3a.3
        for <linux-scsi@vger.kernel.org>; Sun, 28 Jan 2024 23:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706514749; x=1707119549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKwoviPF9lK3MXodrfrYqIC6rePNJHWY3NWvE/KNFG4=;
        b=U7uXVklI6V+bqjGhgkCveo05yEQd8svuDNluOwLk9kJWyR87Vq9dza+UeLyCi3Y736
         x7mCw6gnmQWuujnQK+ESYbgeg/jDauLzM6sPGoJf884sfSois95itnIJRXW4DeXPL04Z
         plBzn3DZyLDKlU2MnTMGGWcOjX0zRquAPVCgSzJhrxWAhmEr608id+DS/0kqi+dCKDBB
         tiPTHqE0uIRLRCVI/s5nk97ijqEec4igZmYsi93Yt4M92BjWXTBBDC4yiiDvB7DtLuBA
         lRivEjK61IvUSUlYDW0WP9+AHpxMWsWWyiJ81r8sPWTyPssp+4iUADkRateto+HzIHku
         R3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514749; x=1707119549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKwoviPF9lK3MXodrfrYqIC6rePNJHWY3NWvE/KNFG4=;
        b=OPDXCK7YMIaIkHbxAFRSB29CTO6op/m+XqeisM+fVJkcQck5K8LbE2YOUuRr0gfqBc
         2wZJZx/+CyVlrwmhDwflpJes6DF+QMQW9SuUjV0F+BxZoBxyo61hIY+E7pU8AsdRb3zN
         x579d8l5Hoz+u8Pdjp5ZB5HIXlr5piowaORcqzH2GBmqOv2HYnN40ZNBCGOWHY0qgnWU
         OrZc3Fx9isdCpnUcEeVJt/a3Z0x4w/eeaaXYv8On9mnaHd13fpgEb+aE22F/uBT/Z/J9
         KYrWuX+bmRxfCdHgMDPZ5aB8LD7Eeiy4hBOWDclsggxL+Gm6OAVWkOeWr9bW5NiWoTKd
         kZ0A==
X-Gm-Message-State: AOJu0Yxniclk5kxEdQledM87dQDJVAy32iLlmfYhQlRiLhceIc93CTj/
	J7FMzxiK4aOOXitLnHCpxhhkEeq1xdsujmjpX4B+7E5+LWWs9GnXDP2hnmhNog==
X-Google-Smtp-Source: AGHT+IGeqfu9dp2sjT94pd6qtcHQFzY9slmsKzbOpFB8yRIcm2BqugXLuSHM1wzJ+Y/sUQaIjfRiow==
X-Received: by 2002:a62:d159:0:b0:6db:d4f8:bb1d with SMTP id t25-20020a62d159000000b006dbd4f8bb1dmr1559157pfl.2.1706514748782;
        Sun, 28 Jan 2024 23:52:28 -0800 (PST)
Received: from [127.0.1.1] ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b006dddd685bbesm5467329pfl.122.2024.01.28.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:52:28 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 29 Jan 2024 13:22:04 +0530
Subject: [PATCH 1/3] dt-bindings: ufs: qcom: Make reset properties as
 required
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-ufs-core-reset-fix-v1-1-7ac628aa735f@linaro.org>
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
In-Reply-To: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Andy Gross <andy.gross@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=tTQT9Ku7RM1FLsAH3vWmzrAWVFN9wIhJQ1xDZJNKp4M=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlt1ku3SWI50z6DJN+7R7fmRweEhh0xY3/ioY31
 p0C1ZBGJuWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbdZLgAKCRBVnxHm/pHO
 9SXMB/4ye39b1v8wXzuxS/o1v4RtjLlLVKqi/NF7kJjRDBql/AeZp2Hf9+s5yn417kUWlbcsLVO
 Hv3+1bV8Qbw+vY5P9VNH9VLyX1ZbqEbk45/TCxNp9Hf++u25PNjappM18E0ZRSOZ6EIFrmMHdXl
 eMcLxBY1kDQjvrbiawIdtPEG7SVhafiLkxL/cnOfCj1bWhvr2n/LljnEtLqsu9eyjHnrXmEjSTI
 FoGhc2e0gJCJADNnkl5dQLibYNJYd+8yNws4LHbb1L3+A0AfU/lTkaSXNsBnqZ86OO+Nsuj2kWn
 OpJjH2fcgHiXyuNP7M6bKXa44uyTFSawclFl3gxssnvZ1wIO
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Apart from the legacy UFS controllers that were not supported in upstream,
rest of the controllers do require reset property to reset the UFS host
controller. So mark them as required.

Even though this is an ABI break, the bindings should reflect the
capabilities of the hardware.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..03dce5e402d1 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -108,6 +108,8 @@ properties:
 required:
   - compatible
   - reg
+  - resets
+  - reset-names
 
 allOf:
   - $ref: ufs-common.yaml

-- 
2.25.1


