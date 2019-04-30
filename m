Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B124F101EC
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfD3Vj1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Apr 2019 17:39:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfD3Vj1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Apr 2019 17:39:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id j11so7693904pff.13
        for <linux-scsi@vger.kernel.org>; Tue, 30 Apr 2019 14:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwbKFy1MGFB5gTzyNOaWfPdpl34v7sKLYfnGqR+QXFs=;
        b=ClF0VW8KdMsiaNjBBcPfdWdDEXBeXVar67U+C5yTdTB8hCeMCmRIjVEO60i2vlO49A
         XHfREvPAunw9db7UklflZybvp4ccCWvWamna7quKRFZN3K+fsAZZjzOxXvH7NEotWc2k
         bhpRoZ2Rj6PPznt1ikDcmW700xh63RbXS3qWBQesdKxjraJDqSLwQA6Mu6BQ0xLv/yIG
         uNXnOlwphpk7aR5/iLSv4vsXKytEmfVSrjBF2aA1B/QI5BEKrn3qOlDf+Z/QeCfuBhZG
         SJhBIVA6iIXZAL37yQpZ8YsGRtNGn5kYsoQET7o8FrlyGIhh6FISR052l7GE7uzpi7YG
         NuFA==
X-Gm-Message-State: APjAAAW7dhvGxQuivW2EkcrFPrv5n5Kac6VaqAireK9Yav7l+FY3c0MC
        Zht5ySPsBgXW8jZhH1cjf2o=
X-Google-Smtp-Source: APXvYqzSZuOen2nkkGfPu7Uz6MwYQgch4JVwOOuZuz0k5aW56mEgpODGOQilXQJYOD4ca3D1ztBmXA==
X-Received: by 2002:a65:43c8:: with SMTP id n8mr67183167pgp.365.1556660366677;
        Tue, 30 Apr 2019 14:39:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h4sm39379820pgv.61.2019.04.30.14.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 14:39:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] sd: Rely on the driver core for asynchronous probing
Date:   Tue, 30 Apr 2019 14:39:17 -0700
Message-Id: <20190430213919.97437-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This patch series makes the sd driver rely on the driver core for asynchronous
probing. Although it's probably too late to submit this patch series to Linus
during the v5.2 merge window, I want to make these patches available for
review now.

Thanks,

Bart.

Changes compared to v1:
- Restored the scsi_sd_pm_domain.
- Restored the 'fn' call in scsi_bus_resume_common(). I think the missing 'fn'
  call is what caused the hang in v1 of this patch series.

Bart Van Assche (2):
  sd: Rely on the driver core for asynchronous probing
  sd: Inline sd_probe_part2()

 drivers/scsi/scsi.c      |  12 ++---
 drivers/scsi/scsi_pm.c   |   6 +--
 drivers/scsi/scsi_priv.h |   1 -
 drivers/scsi/sd.c        | 109 ++++++++++++++++-----------------------
 4 files changed, 48 insertions(+), 80 deletions(-)

-- 
2.21.0.196.g041f5ea1cf98

