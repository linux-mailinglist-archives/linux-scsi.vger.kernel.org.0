Return-Path: <linux-scsi+bounces-3724-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377FD890BD1
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 21:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680501C2F30B
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2EC13B287;
	Thu, 28 Mar 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmihVNw4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1C13AA52
	for <linux-scsi@vger.kernel.org>; Thu, 28 Mar 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658764; cv=none; b=m84Xx04owT90BV8sb1ZVSAGMWKtuOqVasFLjbheTMZOd3clpESUfwrMtDQAYZZQzvqV6x+s4Cq6vJ+mwLn7FKzxzQIbQ7mymHpZ/pUdqa1smjrt2kj6aC536HdZfIN1IvFstYjoFEj7EP0CkZ3gDkYsfQiAXCCBibam8hDdrZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658764; c=relaxed/simple;
	bh=PfP/LX3Ev4ZUehDhY9UJfJ74Jq7QmGOSjpUQvMiYxco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KudC5nLbgKpoGsjrWq9lQA8CYBkZbPe5/Sz6fTjAwwaxX/Rp37S4bi3rkoCrIeuRwJ3mTGUJIseDT3qtxAH0eG40HMkFCK0R49yyW5m0fS5s1tCCcYhmJoDiGxvBySrt+ZlbQ7YeJyLLW1fXFyfxTRFF9M6lp4ad2fPXw1mYcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmihVNw4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d687da75c4so14075601fa.0
        for <linux-scsi@vger.kernel.org>; Thu, 28 Mar 2024 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658761; x=1712263561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYeSOjYCYletYyTMoe7CAWFQDjjR31kHZRvMnXWUDgk=;
        b=KmihVNw4YL7Tuq+7YhileiB47aRtemh8/J7BeQGqMJxqrhxezE9f1hVdd+xYAqXjxG
         ihNUQprPgCJrExHfSM/aoN1ffzqdbsL/3RMyD368rs3SYn7LRMvoYUcrxfYAhc0mxo50
         LFGvKukV4yewczGx3vOmjlRpWlfiZTuo/FInkghSSbYiJbsaXB3lXoXFXb6JAg5S+PH+
         kItcNqihRAPhpcWVvK7xSN5JyAjlPT350kWk0rSijVKvQfZSQZQpHkCewTHfpkh4Cura
         qrYcpADKlBFhkHcr5yaQbqh8oazKBgyJVIXTN8Xdc9c90yfOsbFmLXUP4psx8I9urphl
         ATow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658761; x=1712263561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYeSOjYCYletYyTMoe7CAWFQDjjR31kHZRvMnXWUDgk=;
        b=MqL1X47Z72cGeCMnOFdYfb3gv1cNEM36m2CSkzbGFmX5MuLN7c8yRy0VJ2OjKSixfM
         3HbAGtVwxLnkVyWUlCXywE3aNtDzlQIRQ3JDm8S7Lv8B/TZILO73vn7GeExTzF4RoWIF
         QKIFPc42lmBMYxGMq3cEb3yZi3blovsjPXy3Dnpf/z4g6pe5etOgWpa2Kc6XkO+z5K9q
         0zOnGtwo2dPd8LarisbdD2erqbtCAjHe5csZ22IW3UmsW8R+jwEy3EeAT1ZUO/5b8Vmu
         0UvIY6aXPmGoxSoVsnxCJfjV0zbm+rLmeOrFVucj3H87EZdq0COZliVmyYi5nCobJnkC
         b/Wg==
X-Gm-Message-State: AOJu0YzL4EnuuvUHlHJ4EhH42nG/c2U+Vg5l5oU6zN2WM5KZryfitxSf
	al2dEJIC5oPCt2Tycl/6UFp1DlvNGw/zeIvfDOgvVzXU0STMucp+GAYr331wnVc=
X-Google-Smtp-Source: AGHT+IFvd4/nk37r7rVjow21GdS3wGb58FM6tY77/OHE81pF5KHG9dM3xOb66fow38EUrgKLOcyW4Q==
X-Received: by 2002:a2e:94d0:0:b0:2d6:eaf0:87b4 with SMTP id r16-20020a2e94d0000000b002d6eaf087b4mr173678ljh.11.1711658761219;
        Thu, 28 Mar 2024 13:46:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:46:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 21:45:49 +0100
Subject: [PATCH 5/6] scsi: st: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-scsi-v1-5-c86cb4f6e91c@linaro.org>
References: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
In-Reply-To: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=625;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PfP/LX3Ev4ZUehDhY9UJfJ74Jq7QmGOSjpUQvMiYxco=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb/KToSvZh1tplwoBiPz/6g7+MTtAPeJ3Mz7
 J6OxB0uUK+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW/wAKCRDBN2bmhouD
 1+uwD/9RIGyMDC4NkTCcZceZp1g4yQiblhlfVg5AjfocnBtkJx5plBQSRH7qTG0DwIfLrSch3el
 ZrlAsCFRKO6lDDh6Dqj4wVjJMmjWS5Z57rnqJKO4P9g+cA5K/NGtLcFmidCwdCz02m+dp296Hn1
 RIGjL/SGFEW6Tw2wD/ikOwJX+hGSM9ccryPWaQobKOPEaSAV8aaoTLfMOd15X7UCMUiApWOAsjv
 7TKg0eQ7CeWLxc4l/8YHT4i/Wa4fMNsrWl8ePZCntYQ2OghXMHoEnR9Cljd844NRlkkXxDS6pjc
 Jhd2SscOpR0DVt4amCnuihrWmGS6So1vIEF0bacBPEuyPcvG5sxwA/OPCRFuxEC6Gejq9az3wI8
 l7yZfjjdvRnOdeldBUkvgQHKNihDuism2eMLdO6qEjNQCHNHlp+HoI7b56sm1QLNGPLNXrxywPU
 OYDimeGmit+RCZCYm/m1YDzGUEV/aGOJ+rpIsLEKQcbTYDGq77RB/aVg/rH6dwm6B8Ee75IQ5YS
 Uh5uxBqeW3Cgr9+/TUVQIkAt5v0NDFqvAXEWpxxjLMrmM0hJ+17tVKXMc0DyAIrx4nH3+gdIFVt
 eG2aubpzjmltdyc69Y1EN6UNFcxrIc0VrOcNNKUTcfEw9K9VOxcLb60z+aEWviRZTObNKtqQ27J
 ydKPwW+Q/u1foXA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in scsi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/st.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 5a9bcf8e0792..0d8ce1a92168 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -206,7 +206,6 @@ static int st_remove(struct device *);
 static struct scsi_driver st_template = {
 	.gendrv = {
 		.name		= "st",
-		.owner		= THIS_MODULE,
 		.probe		= st_probe,
 		.remove		= st_remove,
 		.groups		= st_drv_groups,

-- 
2.34.1


