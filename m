Return-Path: <linux-scsi+bounces-4782-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842058B3711
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Apr 2024 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CE61F22453
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Apr 2024 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96721146A95;
	Fri, 26 Apr 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hA8l2oZ7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2620145FE1
	for <linux-scsi@vger.kernel.org>; Fri, 26 Apr 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134014; cv=none; b=M+9aodROxwU7SRyZIvStHxhY1iFLl+OxlzFy5RrD0zw0ug3Zop+LSu/hp4BqNvnU5TkHDI1N80eoKy9pFH6+e8QV9APcBQCjaJC0xAkvc6L7XAHdgDfxp1PqYG5ePOIKINNfnwVVEtXg2tJlO1RPCLRRNrWpvcDuQHpiby16iRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134014; c=relaxed/simple;
	bh=Lo00QN3orvBLO9CxiZxmwFW61cBpMvV5omccjpwyRtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfYNidfcR38xPMQaQq3kDLKr2zwHZxKDKj0P5ARTJ+bk8X171i3wMIS7OdvXrrrAuKNq190Jddo6n9rWnnpgTecLV8BEZxj6Nt9YnikMBFWLgVYDAdKm8pAevqHgtoxmTkBpo5xCVSl9ziliDtRFrv/GiF8CVtZdu3TnfM8pmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hA8l2oZ7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3476dcd9c46so1545864f8f.0
        for <linux-scsi@vger.kernel.org>; Fri, 26 Apr 2024 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714134011; x=1714738811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGiBT+3rLHUSe0fCpI84iZd1Y9xr9GwhBK0cp1D0rYM=;
        b=hA8l2oZ7cOk7LEkLzQKrY7eerivwyjjSLyJDuBPfjK8tbnKx+Faca+WLs8KhMjvsAT
         L8qcQFN5AQ1A8Lw2jbBjYo3377zKwMT3dB3NjE9/9HKqBNgx0fZ6qgqlwOBCoxVNcjtU
         IlpOHs69huMnNWkjqY0+Ej4aV5xld9P97jP16Pd3OXPW87tAz2w2zhxSlUmM6kc5znsU
         TIozRunGTDNN7QYDPpvlptFCuTfyuVL3R/0xNyePVoJeFrLAuGqwWsdqDkf2r/eAKE4p
         9csqy3tcMMnkwd2aS3zIzJzsWgevHDadAXFbSgOpd+8LpSKaQM5QAhRiwVB9VEXcokuu
         /oMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714134011; x=1714738811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGiBT+3rLHUSe0fCpI84iZd1Y9xr9GwhBK0cp1D0rYM=;
        b=r+e4ERI/jTEzBdqvTBbtmFVeEdSuFWwcdj5b7c3VyP/IEKXMjcriNvMvGL9R++DmUD
         CWnXYqj4u1rAyREI7WpPpmbE17i599ukTjE2qy3842slHzOWNha5RKw9r83RwX6p0xGv
         k6zB5YViWLtNUx7uvgNYjlH1olim3B6JpGuPE+c/EpPj+qcw9mNCKVHUZz03RPeTrs6f
         Y9v/xTJp9CQxFhWOY5JdKChwspjt2mLVhwx82Cjqb/Ktv1dQunQbJD8TDJq/XhaB93Jg
         stns1flBAt1gAYRb6iCZOWE2cRmDQ1vO//eCDVp8dA1iAUZJuxKRhG9gs72iObckOFBY
         Jz/A==
X-Gm-Message-State: AOJu0YwEwRHDvmT1QDwNbtdLptkrv0AA0eUk40U3jCRJpkCJZfpdLwrW
	2HvzJf8EzJpfCVDwJjxmUf3qMygdkxxmCC2K8EUZeRKo3YILrmX/xfivo4r78Hk=
X-Google-Smtp-Source: AGHT+IFnZl64tUcUlk94yOZUNVeflszVkGoOajT6n7ta7tcevMv0Y3TwjzY6xunY4Vmk8prFor+Gjg==
X-Received: by 2002:a05:6000:1886:b0:34c:6798:13d6 with SMTP id a6-20020a056000188600b0034c679813d6mr1086457wri.43.1714134011175;
        Fri, 26 Apr 2024 05:20:11 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id q2-20020adff942000000b00346bda84bf9sm22478146wrr.78.2024.04.26.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:20:10 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/6] scsi: ufs: host: ufs-exynos: Add EXYNOS_UFS_OPT_UFSPR_SECURE option
Date: Fri, 26 Apr 2024 13:20:00 +0100
Message-ID: <20240426122004.2249178-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426122004.2249178-1-peter.griffin@linaro.org>
References: <20240426122004.2249178-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is intended to be set on platforms whose ufspr
registers are only accessible via smc call (such as gs101).

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Will McVicker <willmcvicker@google.com>
---
 drivers/ufs/host/ufs-exynos.c | 4 +++-
 drivers/ufs/host/ufs-exynos.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index e8d3302f6df0..66e52c3607e2 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1186,7 +1186,9 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 	exynos_ufs_specify_phy_time_attr(ufs);
-	exynos_ufs_config_smu(ufs);
+
+	if (!(ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE))
+		exynos_ufs_config_smu(ufs);
 
 	hba->host->dma_alignment = SZ_4K - 1;
 	return 0;
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index a4bd6646d7f1..0fc21b6bbfcd 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -221,6 +221,7 @@ struct exynos_ufs {
 #define EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX	BIT(3)
 #define EXYNOS_UFS_OPT_USE_SW_HIBERN8_TIMER	BIT(4)
 #define EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR	BIT(5)
+#define EXYNOS_UFS_OPT_UFSPR_SECURE		BIT(6)
 };
 
 #define for_each_ufs_rx_lane(ufs, i) \
-- 
2.44.0.769.g3c40516874-goog


