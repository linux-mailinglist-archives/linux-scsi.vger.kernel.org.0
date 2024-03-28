Return-Path: <linux-scsi+bounces-3719-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A6890BC7
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2455B2A3E48
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7151139D05;
	Thu, 28 Mar 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJnGDtUs"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BE46BF
	for <linux-scsi@vger.kernel.org>; Thu, 28 Mar 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658757; cv=none; b=HbneHNe8JfbwCr2XcmYBC7Kg3PRewYiDJoUqas+OmKQ/8b+EwGfx3cj/EJr/u6gjkeSmmUO6JgDPkTVQ6An4fmUq+gmWUZDrUAkEXPIUgSAYBxYZB97f6dZmkfJZdA7Z+rkQK5Dgq9oeMqgLPSFh37oYY37mFvuX5vmNItROhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658757; c=relaxed/simple;
	bh=fft4OrHAz+FhYU/1OtFhOBCY8wS5s8+GRl/vDm+Mp+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ke1EtQYb+Ma196wciO5TFiYMedmI0o+66KvzGTDrgvVn1D5Gr5uxXQAiuxST04qhpRl693Xr/X46tVZySvUc8JCgZvWUhNKexj1eQPvENvK67bEmB9R+DotCzVz2zYLwTn1AlEq4UDhmf07wJPtbENzmjYCnkjOF59AiF+2NAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJnGDtUs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415447b16aaso7574985e9.1
        for <linux-scsi@vger.kernel.org>; Thu, 28 Mar 2024 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658754; x=1712263554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHCAelpDeOyTspvDhIg4gg/+myzVVV+bdN1gr4pqQRs=;
        b=QJnGDtUsI5HYWzbHOqFhtYF/x0eGYc7ZBn3XKt8w3dAc/Djf/KrfF+0EjFaNosOFmj
         yJNrKatVBZHibBOh6NPe/cvleJFEN92TTOtCwBTJrKfeEvo++hoMft7HX8sNy75NGIBW
         1PIPXG7XXL2IJa/dS9Au8HRWu8ut35DfTGnpZg2UT7IaqMMhdbPufWcuduRVZD+d8r/n
         ZHJYh1tSVp6z9VLhUDg7G6IvhvlwwK2R/FZDjcUfnkfvxqjxWjKkopqTA5Q4KrrzWYAj
         kQROMlEx3JTGV9Rj7kyhqxrYAaSBzhxntcxUi7m1JttIqVlEu5nuWwDNQJGs5asmoO66
         n1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658754; x=1712263554;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHCAelpDeOyTspvDhIg4gg/+myzVVV+bdN1gr4pqQRs=;
        b=NAesf+Z1qx0vpT2yTUkjc86gaBftEUhsCiyYo1SSqI7qNbNvJ2X8SNflyNy/5qySDm
         B5UztO4mKeojSGE30OXQT/0gkvV4aTXQcgHLtVlRCcSFH4AhinWq/AJtw8qxWcoEpjd3
         ER/2+1NULCQ1slrpjfniOztOkZfHMIF7FZ1kYIwQb9dVzRdFUgLI9wY0FPr6zi9+l+oc
         rxNtT2Ia/CO9AHVPwFCRgxdF5Y7onYnvMkh9Ou/ANOx5kCtWsw3fyerZycGH4BfdaG9v
         Ko4+3FdJKk9v+fIYoAEUKVbnHcES6s0Ws8wc1aqp4/0XZ8wwKLubznhdyIJXfq8zaecm
         VQ7A==
X-Gm-Message-State: AOJu0YyaMnwz3Ey/HuskbCnS5VuoB3rzB+daUAwgP2k1sAn/Lrmd7HZ9
	AvLx8CX0ab4GSWmhH0+kE1Knqi8MfaVwzm6rDDy2O7nr3RPfUxN6JhhJaqVMThk=
X-Google-Smtp-Source: AGHT+IGx1i0glEArl3yYP+MeF600L4ZFfhwyYRmYb/OzKbGsp9z3rF9xSa5fs69ktTjLjash1eKRvw==
X-Received: by 2002:a05:600c:45c7:b0:415:4b56:362f with SMTP id s7-20020a05600c45c700b004154b56362fmr324635wmo.15.1711658753935;
        Thu, 28 Mar 2024 13:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041497459204sm4762697wmq.12.2024.03.28.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:45:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] scsi: store owner from modules with
 scsi_register_driver()
Date: Thu, 28 Mar 2024 21:45:44 +0100
Message-Id: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjWBWYC/x3MSQqAMAxA0atI1gZqtThcRVxojRrQVhocQLy7x
 eVb/P+AUGASaJIHAp0s7F1EliZgl97NhDxGg1a6ULmucChw8+OxEvrLUUCxwlhnNtclGTPYEmK
 6B5r4/rdt974fGaQk7GYAAAA=
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fft4OrHAz+FhYU/1OtFhOBCY8wS5s8+GRl/vDm+Mp+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBdb6jMDSW5dTJ22j6xYqakqZzsHwKgnbk9uwj
 PSYItD1XvuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXW+gAKCRDBN2bmhouD
 11k9D/sGG3YkxmAJvcaSAMR5xVP3k/lGaPgRxbgGQCg7Bh0/7txnl+h9FQRmhLGh0zfBt+KqEgP
 +CD7p8izNocjR9sh/likMTI/JHNgOpllcdw4DuSzICBeO24GJWokHJO2OmjEHqPc9/VnJKYsIju
 y4t10LN//glAlwPFn5zIFpUDVLin4WEFy1vzH4VcCUTt8vkdAhFVgvIjh5vXMwUXJf+tEiz1/Gn
 QUtyyGIxHeYfXqxqrGi39Gfxy+BVbyJKmT2TcLKocWBB8K/XnIgRyj5oyQ0+7eHuHPtW3ITzo2U
 ssVmmcgDhelq70EVyIyNFXoYfik6Z0I/52Er5lobA8jVLbkhQv4eTjD+NR9Z/cVQ07pX/EYVyjN
 ngI9nf13TgAopWw1BkNFQeI7BJH42YuHCW1VOJvKSMfljIVq7YEaS5qBj+H1Kd1Dl01aCux5JBT
 CyPhTJxRe7PCqJFQ7ZvA7aw8sVf+eTmMwARbJMON9kG/d5pNEMEW+aHQHa+ux+xvTqG68+aC++0
 TxQfIvSs3Yb3nNKgUWivnpIUxb3ItuBeM2j3J1xHgxTS3tQJFZfru7JSaXP09iDgoL/uX7yc1rX
 WzU8GYF7rBERjjc1Yqe5Cd1OCi/6E8cieqFRI0vF3hnh1jssVZkEResWRuPOirBGb6Yj99KIW3X
 rpnEzTqdDLKrSCQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first patch, therefore please ack
and this should go via one tree.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      scsi: store owner from modules with scsi_register_driver()
      scsi: sd: drop driver owner initialization
      scsi: ses: drop driver owner initialization
      scsi: sr: drop driver owner initialization
      scsi: st: drop driver owner initialization
      ufs: core: drop driver owner initialization

 drivers/scsi/scsi_sysfs.c  | 5 +++--
 drivers/scsi/sd.c          | 1 -
 drivers/scsi/ses.c         | 1 -
 drivers/scsi/sr.c          | 1 -
 drivers/scsi/st.c          | 1 -
 drivers/ufs/core/ufshcd.c  | 1 -
 include/scsi/scsi_driver.h | 4 +++-
 7 files changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240328-b4-module-owner-scsi-91c327e55bc7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


