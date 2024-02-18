Return-Path: <linux-scsi+bounces-2533-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DDE85974A
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Feb 2024 14:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E228281035
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Feb 2024 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727586D1BA;
	Sun, 18 Feb 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAejksZq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B576BFBD
	for <linux-scsi@vger.kernel.org>; Sun, 18 Feb 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708264603; cv=none; b=l3feJjD+0TZV3to/ztwm+UtR0IHxs4M/67EgpyXqmn1l16h7F/ZE3MBuvnAjFyFBTSDz7MNUY0JAAlDiZCTb4jAH9TWkc/HRNaisnF7NvmxRkBxwS5YiPvxdb4yDofcm47dbMCD+CwXJlTSFlUZHEqrlYN/5NFOXFjLBH45egSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708264603; c=relaxed/simple;
	bh=qjeaOhaCrY4VcmImvKR8DYCqB4V+aBVBAJGTPiEhh3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXAhexMztpzFxNG57dcBkW75fSj6VcKpYgvx7wlzeuRe0jn1WrRrFzprq7w7XC5KKp4BWHka02K3nEaCgkB+ZXZCT/+jWWPKTC2xxUNv8FgxVu1vADYSAHBiPEeDQC5/YG2UnD78izT6ra/QlCPOqp26Ta2yfIV/HmQon9ZTEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VAejksZq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so2458712e87.2
        for <linux-scsi@vger.kernel.org>; Sun, 18 Feb 2024 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708264598; x=1708869398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9uxpSXtWjR5vbZkonahao8rqtm4NaLba001ReJHo9w=;
        b=VAejksZqpPsqFVEASFewlrdJdlSIPsGS5NTRKHkRaMRzWsssoqCZuM419JjrvWclLC
         550blbTsotsh7ZPTzYLyl8mna83/KNkFiUWG1xGB89Y/ftwY/Lfxd0xy9yR7vQFPLm+J
         17eHu9cGyG1HRPb4x4TECO4GSieM58XdwDP3zUB25Z14DCJnc8Pq8Hdr77dD4yPCgbUT
         wPy4kjJBYA7g+eT+5Gi7pDt/Bo7h/jxYHrPiOr+7gXPTjpYfiR1H5DqZEbJPqK2J0UaB
         WBdWa2XzbdDr5vi7N9MqXPiJLBctddKbl5aPmKm6jyxT5ClXGPXuK8nH3K77gfBdku3e
         ybLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708264598; x=1708869398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9uxpSXtWjR5vbZkonahao8rqtm4NaLba001ReJHo9w=;
        b=ldGAgUxwMF1i8bEtPg5cKwdlhlU5Pedu6RJAx03FJvC+159H/pJPM+02RNJPzdbVBx
         srMRuOkDltz+/IicYp1TQC/yfupdgo35czaWTygYiSVn8R0/dijAeeiEJ7tlW/Hp6Oq1
         BlZbzMtF4Fs9ozItYriH9aBTAaGM04yujMaweF+jS5TdpNMl4P3TuCyXANQTa98aSyeC
         LNKLFt+27pX+w4D+8QqxWeARATX//TfcqC2epYKNoxKwFFdUCESURAktn40qfo7udyYV
         RY9HHW+0BNrHYhOnRyMZbmK7R0wMefbxYUbEAVIULogjfGyuVJoLrrxNoAylbJXzkSjF
         Iblg==
X-Forwarded-Encrypted: i=1; AJvYcCV7cc2jr8WiBrcVnkPJxlWMbrjLQkcJLBYzZlcYpSsOUj6jQObSGpCOPdmt1GoMgGFTTTIUktfIceOcU4ygn0tQvZLbAtyCxvzoXQ==
X-Gm-Message-State: AOJu0YxKzFVlqFLLFWnVywAnSWwc/+ZU8UiB8vAaF9axiNrZW00OyPRK
	c9wizVrsscdXOCZGico4ri2Y7nypYERAhVONe+2deoj5b/wq5yDGcO/JsHC0T8I=
X-Google-Smtp-Source: AGHT+IG3o8o/a4+lttK6f9vGAipl3Rr4H/zqGBtpaamLytI2dyMtTrm//xygZ83Nh1MHwPq+Dvj1eg==
X-Received: by 2002:a05:6512:358b:b0:512:ab03:1b with SMTP id m11-20020a056512358b00b00512ab03001bmr1277442lfr.53.1708264598338;
        Sun, 18 Feb 2024 05:56:38 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b005119fdbac87sm548698lfq.289.2024.02.18.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 05:56:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 18 Feb 2024 15:56:36 +0200
Subject: [PATCH v3 3/5] arm64: dts: qcom: msm8996: set GCC_UFS_ICE_CORE_CLK
 freq directly
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-msm8996-fix-ufs-v3-3-40aab49899a3@linaro.org>
References: <20240218-msm8996-fix-ufs-v3-0-40aab49899a3@linaro.org>
In-Reply-To: <20240218-msm8996-fix-ufs-v3-0-40aab49899a3@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nitin Rawat <quic_nitirawa@quicinc.com>, Can Guo <quic_cang@quicinc.com>, 
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qjeaOhaCrY4VcmImvKR8DYCqB4V+aBVBAJGTPiEhh3o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl0gyTvsrx5bGHb1ytmU2tJaqUSojI5Rdb4BQFM
 VzRV8pyBdSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZdIMkwAKCRCLPIo+Aiko
 1bhFCACSfsRIe8ROLD7IVDgsrBnAdV5w1za3tCYtlJuN3c/l8kg5s0wBD0dvtYpzbf7/nGe9YwW
 9RbcQ23zHcSZt7y7BOt4C9LsWC9AlHuKh8R0hmdEE+OeoVVZC9O7ckvaq9jP+ODA/PmFVHzih3r
 h/adx6BnUk0T+2u1bykv/2jvtx/j8s8gENDKNY86o6UvX3J6XZTIqH/8o2mI7m4Gpwh8Vw2V58r
 ysWqR6Bu1VHHXzZnuqSAML3sbJZ8OInzzGzwW8778dyDmfI/YsXE9nwwoxu4AwFfSCRAACohsGI
 c0JR9q7tRydt/ThSpwX1YaTVCN38kZmoH/yS82DaPi/SDlou
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Instead of setting the frequency of the interim UFS_ICE_CORE_CLK_SRC
clock, set the frequency of the leaf GCC_UFS_ICE_CORE_CLK clock directly.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 401c6cce9fec..ce94e2af6bc5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2076,9 +2076,9 @@ ufshc: ufshc@624000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<150000000 300000000>,
-				<75000000 150000000>,
 				<0 0>,
+				<75000000 150000000>,
+				<150000000 300000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>;

-- 
2.39.2


