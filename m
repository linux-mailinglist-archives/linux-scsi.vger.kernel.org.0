Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9168333FE8
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 09:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFDHUF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 03:20:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35642 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFDHUF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 03:20:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so4202222pgl.2
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cW54g37zzSz4GWvh5hRmHVol1ElNCqsUtdX3i5TDki8=;
        b=RtBWZujoWwW3pFIZuHpnWrxTc8YvUZAJEdbpx9IY/AVKKprlylZPo4sQDdv+iGW4f3
         BD2uhbla9+ITaG+pHmSjpvZ6jmb9i7Shw7kH3FG1mQIuzf6Lc60QAFndAoaY80zc7gQJ
         b6BcwbyIqhZa1t93ZOHF4wBec3eumarIxn2Y44vVRphfZg4giYiVNtIVx84AMWaSVzuX
         PFJT4EEWaOVsk+nBA8U2nC7/MZsLgO3a/rr5LOrZjkeCAcCqHViQKrKWGsR2i4iWgU37
         21RwAgEHaunjZ0eB5GI7IrxjfCr8qk8hEo4yHZAjJoUbLTjoKrKTC2mGKsZ5u1aX6TLe
         UlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cW54g37zzSz4GWvh5hRmHVol1ElNCqsUtdX3i5TDki8=;
        b=hPnGKM18psE1dsqOHWypyH+cPMIh0KdhkMlttKMwmU/xUpxpNt0pF47ggHzP1IGYrp
         oHeTBZ1ohIHJrjsPPZEjrPQKkQmYIvBHYedBlPfHavWOVKvv3NU0RlMo1FR3Y2wxaSdL
         zh9yYst+aEGxShrSosmDCoQe0tm2Uj82IOMQEHRLV7FxerAR4PDZNzpRyfz6FLBIZnCS
         Kxfts34evwV5CYMqfTO6WWyp1dr/PyvQ1+n/z8SZ02HZjgcF3/iJ/icTFnEnxogM7+Qh
         w1ZamCP0lJeHOw6gkmRBIm5+N/hMntZw9o8tjPshczeU9d6KSX04gCkH5QmOVECp9X9o
         LC7g==
X-Gm-Message-State: APjAAAUMPZnKimoqpfkWHQCIKTr0qNxQNSVOTTiVA/6Yh2dqVal1PP+6
        ndJ87v7iITIsdpgJeT2eZEaN1A==
X-Google-Smtp-Source: APXvYqx5aLQZoHyol1PmiF+AvixuAC4swlY3kkqgRqnYCzZ0I1A/uWV/nxPZxmDkkkzGfx3kB+M9PQ==
X-Received: by 2002:a17:90b:8d3:: with SMTP id ds19mr34718088pjb.135.1559632804480;
        Tue, 04 Jun 2019 00:20:04 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm17747446pgv.4.2019.06.04.00.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:20:04 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 0/3] (Qualcomm) UFS device reset support
Date:   Tue,  4 Jun 2019 00:19:58 -0700
Message-Id: <20190604072001.9288-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series exposes the ufs_reset line as a gpio, adds support for ufshcd to
acquire and toggle this and then adds this to SDM845 MTP.

Bjorn Andersson (3):
  pinctrl: qcom: sdm845: Expose ufs_reset as gpio
  scsi: ufs: Allow resetting the UFS device
  arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO

 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  2 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c         | 12 ++---
 drivers/scsi/ufs/ufshcd.c                     | 44 +++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                     |  4 ++
 5 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.18.0

