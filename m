Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2539B36
	for <lists+linux-scsi@lfdr.de>; Sat,  8 Jun 2019 07:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFHFEy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 8 Jun 2019 01:04:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39132 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfFHFEy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 8 Jun 2019 01:04:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so2202448pgc.6
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MI5UP8+6YzX1wT43lJpua6JKjZgkLt+dbe6TcXG9cy8=;
        b=Z2HdysXy7QD5MtVYuQPu7sZPtUTxdmzw3yNdieEQ6kdhO6eifQihTq5GULJg7Y8de4
         aUQCU2nclqpJsZzBm7Y1MWR8uzCyK8PDAwKAgMWAFMs/n6q99tqerXjRgrB844Rziliw
         o+i/m88RKRI5RZVJjuni8ysJclc4uYOq0kj++HvzY5ZLuZZPj+d7vT2nXdQbFifX0ewn
         zkNMcnGiJeVDKXaglu90C9ZRixUeowTKmwUl0JJd8LM4twLryHXcWHMMgXY6wcUZkdDz
         My9j6lsxDaQfpaL/vsPij1ymzOqJrSAGwpIbT3v8vr8wezhuUPM/zD8BneLzK3hJXfvF
         zfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MI5UP8+6YzX1wT43lJpua6JKjZgkLt+dbe6TcXG9cy8=;
        b=Jg+UB5uOxKCLpBknO/5KwK0jTqr4QBIn29xKUGlcR8B8BwikwOELY0iTEkQwGjMU6e
         Hx4vdhdGgEPQn7Uai2kzyIjo2jzOobMRqos8x6e4rO6QeHvhCvQ0vqAa5URzMejzc+43
         Qyn4CKScC9DiwTw7ImiPwg3fNSx0nuuCdizJ+Fg0weuP4yTFDG8CNO0yVy4klnu5fr7P
         aTLuLeB9i+PAotg23LpyiId/X7vvnK8Rj3kw8a3wOQTcpIo2Zguncu38V0BlZYTgp3Cv
         lwRTsArrvcWwuPcYrtApzC7KlqcrbqaUsaD6a5XEmxKfkp/7b8iA05dDtDje/7vCkyku
         AZXQ==
X-Gm-Message-State: APjAAAXan/aBgC04JAPh5nAvtAxHAaFPOnf/+B02duELhm5XOlHnBmbD
        xvaKa+qE3eGMVz0SuIuzYcDqKA==
X-Google-Smtp-Source: APXvYqzgWooneYqQXysZKH4LudPeWAk7m7Gra9BixdXpmIfM9kEjOY99VzJO08laxBbJSRvlGoVELQ==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr47155236pfb.0.1559970293715;
        Fri, 07 Jun 2019 22:04:53 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b8sm4522482pff.20.2019.06.07.22.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 22:04:53 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v3 0/3] Qualcomm UFS device reset support
Date:   Fri,  7 Jun 2019 22:04:47 -0700
Message-Id: <20190608050450.12056-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series adds a new ufs vops to allow platform specific methods for
resetting an attached UFS device, then implements this for the Qualcomm driver.

Bjorn Andersson (3):
  scsi: ufs: Introduce vops for resetting device
  scsi: ufs-qcom: Implement device_reset vops
  arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  2 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  2 ++
 drivers/scsi/ufs/ufs-qcom.c                   | 32 +++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.h                   |  4 +++
 drivers/scsi/ufs/ufshcd.c                     |  6 ++++
 drivers/scsi/ufs/ufshcd.h                     |  8 +++++
 6 files changed, 54 insertions(+)

-- 
2.18.0

