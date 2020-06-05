Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC81F00AF
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2020 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgFEUFw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 Jun 2020 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgFEUFw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 Jun 2020 16:05:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9EC08C5C2;
        Fri,  5 Jun 2020 13:05:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so11390968ejd.8;
        Fri, 05 Jun 2020 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oXpENYoZNdPeFaa0kqGIkIEL7ooeWiWEmydsTCzHOgE=;
        b=gJAZhqq8qvZ67jX77QOVCihXoXZdp1e7DQUWsZupu/M8dARkadrdlGNEPqdMGNZD1h
         HIpF0eZ14M/Hvx85dJ9BFzicb1tLyhYgpqgczYKqmO+q0zj782ulQD5HYXjS96FcFcps
         7DSWT9qGCLYgvUYYG2TZXekwgyrwcv4gs1gCXVYZVwBtVJILPXQyHDY17pGSMxWTDjM7
         7TuZttqsvyn5dJRdYMciSsKdwUy/9xr8EQlRKd/t22FjOAI4G8VrdKieoW0rflvUR2nb
         s0rLHTadCLjpcRvxAKzIFZp3rVlU6hXot7ZlU8Sg2XMo7Ai7kXzMHccdSFjxPy1DUNT2
         gntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oXpENYoZNdPeFaa0kqGIkIEL7ooeWiWEmydsTCzHOgE=;
        b=YZra4vDebB1uqWyDjpqRJJdBhnGITExHh9V0aPkByZ1qx8qyyZepAaxIGPjKR7c42I
         mYNry5/1HNAwS2jbKCFbcjLq3GdOMDbV9TCm6YS3HQvOpRef1hmusm/6bv/VYfcLQDxr
         sc6xB4xg/Lnyiqc2eHaccxw0VSwl5SJd8W2hajyJyiZ97IpOOCvizJJAy1I6kZkkjA2D
         cTqjWUFHG+vr/0nBrHLJim6QFIarmhTxcdmA1wrS6GppxaqdSyVU+gz0Xcl63wkjoSM+
         zu2TRPPba6rNSLTESJ2d7nOgfKCNFCHP3dTBIuc/s+9foOIejdF+4oE/VlTr7CyX8n3A
         wQSw==
X-Gm-Message-State: AOAM531eBDv+IZxyOUPvS/3EREvoz4eTcqvSPtcjMuWsKkAByC+ffjDR
        tMpBsbS0slAJzijvaUKCV9s=
X-Google-Smtp-Source: ABdhPJxtn/Ht25J90zk+Z3seL4YW/tuU//8++ZP+q0l9Vc34DlkOMQq8Kp6kb20RUzBOllT/wt8lcw==
X-Received: by 2002:a17:906:4350:: with SMTP id z16mr10085294ejm.139.1591387550586;
        Fri, 05 Jun 2020 13:05:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bfcfd.dynamic.kabel-deutschland.de. [95.91.252.253])
        by smtp.gmail.com with ESMTPSA id b21sm5224430ejz.28.2020.06.05.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:05:49 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, ebiggers@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] scsi: ufs: cleanup UFS driver
Date:   Fri,  5 Jun 2020 22:05:18 +0200
Message-Id: <20200605200520.20831-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Cleanup, no functional change

Changelog:

v2 -v3:
    1. Change SPDX-License-Identifier: GPL-2.0 to
       SPDX-License-Identifier: GPL-2.0-or-later (Eric Biggers)
v1 - v2:
    1. Split patch (Tomas Winkler)

Bean Huo (2):
  scsi: ufs: Add SPDX GPL-2.0 to replace GPL v2 boilerplate
  scsi: ufs: remove wrapper function ufshcd_setup_clocks()

 drivers/scsi/ufs/ufs.h           | 27 +-------------
 drivers/scsi/ufs/ufshcd-pci.c    | 25 +------------
 drivers/scsi/ufs/ufshcd-pltfrm.c | 27 +-------------
 drivers/scsi/ufs/ufshcd.c        | 62 +++++++-------------------------
 drivers/scsi/ufs/ufshcd.h        | 27 +-------------
 drivers/scsi/ufs/ufshci.h        | 27 +-------------
 6 files changed, 18 insertions(+), 177 deletions(-)

-- 
2.17.1

