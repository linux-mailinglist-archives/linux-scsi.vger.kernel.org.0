Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3384F9D22
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Nov 2019 23:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLWe5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 17:34:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42455 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLWe5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Nov 2019 17:34:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so60195wrf.9;
        Tue, 12 Nov 2019 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wb1Drv4ONjZhH9+mj+82CJHFlmyGodqqNi6A+Xmk3Xw=;
        b=FRVWpoTxSsoh77cVnCDAag91RQbtkNfh61zahp/5u4GoHpP2ItnBWtarNikfE30e4b
         xgMUIP2pg8c7P5M0AGzzk7pZvziV8uoytvcoIK8KnQH96BNO1RDMLJVH4IHyhlNszNmY
         yOCepQqqeMuT2aGC2OIBqwHgLnzLT4tQNGFMT+Y2bPWytjg2VmmiUIoWdA3YubUH59Pz
         ls3XvSQ8xB0sTbAzTb1bBXDm8wKs9FYzJmSTNvodY5aYjrfUwPgT5L84wRCe6atd8Oo4
         KK4QKVFq1IG8SrjRg7+SAn/WWIWPBXOSRH+oSIxE4cJUS8Xhf2veNNaEwQUBwDW9ANdw
         a7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wb1Drv4ONjZhH9+mj+82CJHFlmyGodqqNi6A+Xmk3Xw=;
        b=KTpWvl2wZ03BCrm5nIYA9zKghHRePqWZwP79qI9bJWa/f9OnDUhPcJMWO/sz16tNft
         IacDKGFj7G4szHgqRg4X/lyAT0Sr75USeveZEIDLIWAC5EiEnLVlcUsnZ6ZOOBXYR4TH
         S30+VgDDd29tJ1CChyYNSLM0vJ/zgVQhMGGi4SKpWjvN7i9c0bUWT+HBy1VhsphpHHa/
         ExSOM24Tabq25ozDYKNC7a0Nde2vcFTgc9j3GoAM5HKWcCd1gABBo8OzI5xlw70QGpoy
         WK5bt4t3VLW9mkzcmIRlgXTwyy5avxgRe416KOmrQVTR92oR0HZZjA59/Yt88B6RKrUu
         uw3A==
X-Gm-Message-State: APjAAAWq1xeZY43ELiSiUcYyF4MJIAZgBlGCApYVtlHeunGaZhsipZpQ
        eI8fjx3I8OqxvWPGsc5mHpM=
X-Google-Smtp-Source: APXvYqwXyaOALEq7d0nWRlmUaOOM2L78swtp6xJT3HPwK/KWDAXczQ7YIOxTcaQ+pIzsPMdxq+tIjw==
X-Received: by 2002:adf:f490:: with SMTP id l16mr28107897wro.77.1573598094717;
        Tue, 12 Nov 2019 14:34:54 -0800 (PST)
Received: from localhost.localdomain (ip5f5bfdef.dynamic.kabel-deutschland.de. [95.91.253.239])
        by smtp.gmail.com with ESMTPSA id d20sm584356wra.4.2019.11.12.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:34:53 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <huobean@gmail.com>
Subject: [PATCH v2 0/2] Two small patches for UFS
Date:   Tue, 12 Nov 2019 23:34:34 +0100
Message-Id: <20191112223436.27449-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,
Here are two small patches, one is to fix a potential bug which could
result in system hang-up, another one is to add more helpful debug hint.

v1-v2:
 1. add reveiwed-by tags
 2. fix one typo in second patch commit comment

Bean Huo (2):
  scsi: ufs: print helpful hint when response size exceed buffer size
  scsi: ufs: fix potential bug which ends in system hang-up

 drivers/scsi/ufs/ufshcd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.17.1

