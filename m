Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A293A395927
	for <lists+linux-scsi@lfdr.de>; Mon, 31 May 2021 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhEaKpF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 May 2021 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhEaKpD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 May 2021 06:45:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1EC061574;
        Mon, 31 May 2021 03:43:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h24so12079241ejy.2;
        Mon, 31 May 2021 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRDWLXAck1raFp8VVUs1f+mKxKULvRviPycYi4op11g=;
        b=m7XodNLph4OruuhYIefg83obccGHvKBocm2gLu9zwfuxGpyDF6izlQEsgL7d8Or9W4
         XirSMhU2x7KqxLD/r8YDhtI8NBqmACPnpQR5VnElxvS3KdG9IZJUWlxgq114rWEs15xk
         iZTX8SkVmaxM4L97H9+lOnIvlIlbnKrwP98tGluWZSADdli5DFrM5uHdfNiV1xO2idLf
         lK41Y7Rpcbu8wn+8URGQ/1XVEDkCbSlhs0bsfZ0S9j+oWl42EdPHMe2bDkEnehHsIlH2
         1qrABwYZyhQdinjbqy7K/IeNwsk9L4+hFQ95/TitqV+27Pfi4FqvszjwZaogHIXUq5iB
         lJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRDWLXAck1raFp8VVUs1f+mKxKULvRviPycYi4op11g=;
        b=CCkEVOhrUELVPcp8s8XTSHHtbXyNw2GVO+pOUr7/yv301/XS5RtJks3H7Iwa3WlH2S
         TkXERkWAA2KMDOF6HTCaArb8XLn27QIe3EBsdV+6xPjMjANa7LKIcKCh5UOG/mQtwvjG
         z+MWucLHsc5l3U4g2u8D02oUcdL1N940STkPVGToEPQPNyjNxwWmULtltwJy/5qfAqL7
         zX/Q29z4cOCJYZWgp/jSoh/Z2faAoZuT6gYtRyfWCSkhYvgeZ9JGCPqm/M5HQcsUhAbI
         eYYApZExC3zQQAgLi6KbRrK91PBjQecZiPUHAIUW1SenOb5kCorrth3JZ8PhtB/uga2B
         509g==
X-Gm-Message-State: AOAM533CBKhYGo25d9NN9P11EZc03UiGi89mYmhN40eVH8xRE6Z/nj8I
        DEE9RQUhdQEWjmaUXMdWcJA=
X-Google-Smtp-Source: ABdhPJzHtsIy12jh8754dJy0wkqagMnp5PySrjvyTlgRvRehHxswmkwVRAgePbfAW6dCALlI9c//Zg==
X-Received: by 2002:a17:907:7713:: with SMTP id kw19mr3821943ejc.249.1622457800884;
        Mon, 31 May 2021 03:43:20 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id dk9sm5741035ejb.91.2021.05.31.03.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 03:43:20 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Several minor changes for UFS
Date:   Mon, 31 May 2021 12:43:04 +0200
Message-Id: <20210531104308.391842-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Changelog:
 v1--v2:
    1. Add a new cleanup patch 1/4
    2. Make the patch 3/4 much readable by initializing a variable
    'header'.


Bean Huo (4):
  scsi: ufs: Cleanup ufshcd_add_command_trace()
  scsi: ufs: Let UPIU completion trace print RSP UPIU header
  scsi: ufs: Let command trace only for the cmd != null case
  scsi: ufs: Use UPIU query trace in devman_upiu_cmd

 drivers/scsi/ufs/ufshcd.c | 59 ++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
2.25.1

