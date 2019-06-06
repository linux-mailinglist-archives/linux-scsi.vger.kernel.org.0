Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8158B368F2
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 03:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFFBDC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 21:03:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34484 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFFBC5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 21:02:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so210935plt.1
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrcbvKOldgWkH50kiW0a4HfpMKXomzEmet187F9e9WI=;
        b=Qd9d1msbSQb53Iq2KqsHsAFxY5JW7/DojKA2+N32CgI93O94JHubPZWVlC4T3bAMJr
         ZrvFCj/RzF+FbICJpj5JCH4CSTEAarhBE+BW5cjaT/fhsuBRzHh4R4kg+eUsJkXcmelb
         aJRZaXGTdAXba/9Zyk31ploH6ku4OjM3HOI4G79WyWiadhcA/+hLyoyLuNP/7hmImK4s
         yj7Wm+GpGOxYDWvhRDlGg18PZFunPptfjzeUCnWdgmaLkwE47/RuxkhrxK4Na8bGlHe6
         qFcEbErPiIJsSTnCUmMVu7jomRuNUC1mBrKGUgXmeBtTMd8nZ9ibn65B24CxyjbksXiS
         yxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrcbvKOldgWkH50kiW0a4HfpMKXomzEmet187F9e9WI=;
        b=FjaJCjY53owAGRTatLa3ON9vjQVc9vFy9ZqOk8MPmFx1GA8SkO43B40BT9BBZ+UjJm
         52ZLdDU/4HXga3OXnVgcRjbvSsgy4fN5SixrKI5pt0KSB4QxaHZDZp3emDf6AaSt2Dij
         5tDVok2r4ZVKVqO3/oVw5Y/np6c1EZs80kIjOMTv+C2aYn4IMZDubTkmgSPsKpQk2cN8
         VK5MeYlnDCKEzcuN8xtFCB3D1TegpnOnqiqKvFpjwdm13J/sv/497L0Pz2Ozbd042mpf
         wtvjVhzDRASZLqEJ/aatI2wT2hfrUdem7v5K1B320A2XrE9O0Pkz/yfohNheO0wBc4Gk
         PxJw==
X-Gm-Message-State: APjAAAVRAIRar1zdmFz3wGw+tQfGM6v3x1c0+KcULbQF3MJEBU0VTftu
        rWZVzAMLt0lkmwe/NrC7EiKisw==
X-Google-Smtp-Source: APXvYqzxPgy34UUwtKp+qsxEzAqNHyHrYFZnGo1PhXfMwMDzdB7H5vaW7x7ustTZPxvF+bd24ZmJYA==
X-Received: by 2002:a17:902:a716:: with SMTP id w22mr47239553plq.270.1559782976660;
        Wed, 05 Jun 2019 18:02:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm170856pfy.54.2019.06.05.18.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:02:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO
Date:   Wed,  5 Jun 2019 18:02:49 -0700
Message-Id: <20190606010249.3538-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606010249.3538-1-bjorn.andersson@linaro.org>
References: <20190606010249.3538-1-bjorn.andersson@linaro.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Specify the UFS device-reset gpio, so that the controller will issue a
reset of the UFS device.

Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 2e78638eb73b..d116a0956a9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -388,6 +388,8 @@
 &ufs_mem_hc {
 	status = "okay";
 
+	device-reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
 	vcc-supply = <&vreg_l20a_2p95>;
 	vcc-max-microamp = <600000>;
 };
-- 
2.18.0

