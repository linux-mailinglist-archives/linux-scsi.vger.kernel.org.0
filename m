Return-Path: <linux-scsi+bounces-2323-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69B84FF31
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Feb 2024 22:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8896B253D6
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Feb 2024 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156B37708;
	Fri,  9 Feb 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhtkEQWT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1683364AE
	for <linux-scsi@vger.kernel.org>; Fri,  9 Feb 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515441; cv=none; b=e8RukLa2kJQbHlGHD6M+kdKF7t0X8E+lgAlwveubaY96kzhAX3xlEejxtEuItbHNumGrF57r+CBD6YxKeYMTp896ry4xqLnbXFYAU1+vA6rdsddTYz3tF7OQGYCP/SQTZRGIdosrw4ncEANI+a4Us/K1kjaxCMChXgwg/+UKC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515441; c=relaxed/simple;
	bh=lme1RrLHypMhP1IKVUdYE5epWMb2CFcPlYghOxVFbxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvtpRD0nUPYe3337DEUETP1eMATmeNT/xQvOaGdKQGpXRWUI0BxhRpIQu4fPsV1qnGFica5EB9mr2BdABsvi8SPfCM6ZtqBIdx427L4QZnElhSpwqWjhXUrYiuPK3kJLrLhuJE/YlHfhEG0tK36i4jMz/++OTBGqMghXxcqX69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhtkEQWT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0e4ef33b2so1842841fa.1
        for <linux-scsi@vger.kernel.org>; Fri, 09 Feb 2024 13:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707515436; x=1708120236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG1aT5LJNwH/dRpQTGDTuFAcKwHfCgYh9E9LjUpdBHA=;
        b=JhtkEQWTpChQ5Fp/02YAYMpWSYI+i0RRbgS5h7oYL+jKdc2VJj33ZCO9tx/lNcD/hS
         tdybkKwKBTqfa/PKVzvjktJrfpy/f+PwBkN/sjf0GhaO2AoWKAC7iHjVxRPfQSIf51/h
         mi1ocAstFueCphYgjngNidqfTn1MLbcVcCwjHJhMTIYiyhtVzovBhIGdo2cu4MfzQN45
         BB2/suKys50FWPid0kDjeqwpEn7oZXgfVxVUo8yIWLzGrjMGNszF3rRM4MSHe/Ac6enQ
         t0yXbK08X4LrAuq1DeaagWZLkAwb3yXRcKL78gxpP6tWO4VwqV05QBRGp4DkJ8R7wqaU
         cRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707515436; x=1708120236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG1aT5LJNwH/dRpQTGDTuFAcKwHfCgYh9E9LjUpdBHA=;
        b=nDiEw7CgX3BFkzGy7nD2ujLq8KTD8H1Kx5/MDyp4tESJnhuhXA/YfCFnAfJWqjBVe6
         CrNVIsT98cUzRk/hz6XsjpYw1LZhEyyXf6/YWTYBdXO4XE1uV0Z5dXEbmLtG2iqyxpgq
         WM/1gVdi8zDOReAbfZop+wgpG3SHdDmlMlzTtNBd+uHe/wCuPgII8q1L2R1Fxk+IW2dh
         +Gh1oeFYaOORVjV9SLIvn1QxfB9waRjhqMntehLx0lvA7Z8NLYw+Zcowxo500rmgGcZJ
         57S3gsCiTjhz5TO6NHRLg6un4hQDTgQbru7ln77GHus6b/Oi4rFOg8H7g1hiJy4tbG1w
         sp7w==
X-Gm-Message-State: AOJu0YyW/GVdMNki+bj8U33LY2vP1VY0F84erT3rQYh7ZGj4dPH263Jn
	q6ujjgPSTLg6ToUs0be8EHF2Q+S7HaKsV/LB31VHuqZwCT6fQwwGf0v7/KDhEmE=
X-Google-Smtp-Source: AGHT+IHImH4Xw/8GOnfoOdrfHRI/2441YEadUX0HeBbadTOpIUFEEUW81H8QqC9NKnRKVA6iEaC55Q==
X-Received: by 2002:a2e:9c8b:0:b0:2d0:e296:d640 with SMTP id x11-20020a2e9c8b000000b002d0e296d640mr197083lji.11.1707515436775;
        Fri, 09 Feb 2024 13:50:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmlCfIbxj7QoKywHEuRvf43azqfOagFYXGGhGLbk/WKRrKCbK12mEuMYYC/3j1ca2tw4vhJNlCs7aXGWr5squyJEyfww29DYatyjqynNfvizbwJKVtgFi6r/CUXchTqdA3dLmESAhqZBMZ38d5YYDIHnwfU1MHYmLBRrOZ9WJlENhXaxeauUnApSX4Wu3sFEvc97QWiShIP5gX3nu1kQFsWhmMfpN5N/Y2UomPY9SP99CKp9ileMj7N10MdXeNCTjimIvJyZ1j5ul4rQ+7NR4ea7fS09mDnXkLlIIljMs1hA0qAJPf0t1dMh4cVigj7OOcNNY4kGZNOb3zxaocadHUprGJ/tyxZMJaDm0PGAuaf5vWZ+W+wiWe8aHeTFsxS/uAikyyCpftivDYIR8vqJfiNoElLFbVthsa3q5EOZNA/JluOGM7fCm8gPjULKaM7bN9Nmcmq1U2RtQzArSBW5HtmkHivnF14mUJD7HxzzGzf+QJrKH70Q4Mc3raX7soE67gMR3cCMUa6gv9FqsINxDf+PeQpD61/v2DUH0cBaZoOTjNuaA1ASUPCe4m3fekY5plA3Wyqwv8f0pr/4JhxJluD2Av0kwgmyo=
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e2d01000000b002d0ac71862csm391162ljt.9.2024.02.09.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:50:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 09 Feb 2024 23:50:33 +0200
Subject: [PATCH 3/8] arm64: dts: qcom: msm8996: unbreak UFS HCD support
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-msm8996-fix-ufs-v1-3-107b52e57420@linaro.org>
References: <20240209-msm8996-fix-ufs-v1-0-107b52e57420@linaro.org>
In-Reply-To: <20240209-msm8996-fix-ufs-v1-0-107b52e57420@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nitin Rawat <quic_nitirawa@quicinc.com>, Can Guo <quic_cang@quicinc.com>, 
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lme1RrLHypMhP1IKVUdYE5epWMb2CFcPlYghOxVFbxc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlxp4om9AdF+KEigHcO+gUHEp2estUthJn4ZfFk
 q7hdNIxcl2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZcaeKAAKCRCLPIo+Aiko
 1cy7B/9BYW+GCvAnSvNFR1zqowRnTsJW8Hgvg4UjhOn3GEZQENNcrEPOzR7lDotXiX24M2vG4kC
 cx+8fXE+L2O2oZzO364S5sB6HCOeGE2W4JjltbYtuiJNs16EAEA9TG53RZqeioYt6MsuB8tHx+2
 py+Evqoeh4luSLKnh9aSipQt0cpLt19Qv2V9gsUEzeW816ZSPv+kPshVl5sCqYDyi85eptD5Jbj
 4LJKW5CoZUq1fTio58YFg72J5Y3mTwhbbOZgmxk+bfdyVqhH7k2su/W3jAR/C/OI0NZ05wlEYsU
 r5j1qxsLPULLZiOl4kYz9zbxrovBjJ3HBPGUiiaeK/dGr+qu
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Since the commit b4e13e1ae95e ("scsi: ufs: qcom: Add multiple frequency
support for MAX_CORE_CLK_1US_CYCLES") the Qualcomm UFS driver uses
core_clk_unipro values from frequency table to calculate cycles_in_1us.
The DT file for MSM8996  passed 0 HZ frequencies there, resulting in
broken UFS support on that platform. Fix the corresponding clock values
in the frequency table.

Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f6b6fdc12f44..80d83e01bb4d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2077,7 +2077,7 @@ ufshc: ufshc@624000 {
 				<0 0>,
 				<0 0>,
 				<150000000 300000000>,
-				<0 0>,
+				<75000000 150000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,

-- 
2.39.2


