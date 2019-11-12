Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDDCF9931
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Nov 2019 19:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLS6h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Nov 2019 13:58:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38206 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLS6g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Nov 2019 13:58:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so4136303wmk.3;
        Tue, 12 Nov 2019 10:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2OdOpykLsnzEhklgJ8BjBEIsUVROm20WmbImz3r38Rk=;
        b=qD1e/8cyjxwpbPSHczSXIaOekW7n7WcXndDSQ6w4Lhnrmh2GWe6vWgI13k1z9Ullt6
         AfZL2JF0TOqBZKUaoESYvkyMoOrpa7MYUHmQBjoP06JVlIT7Jskkc+ybpZm626Lh7q6+
         gpl9wN2KqO4JtZOcl6fgFGTbnhcH1e6mGsWEwES98k/9YXvnukgzgyTFkptIAcJX2FgL
         HqKFLNfqhUTohHfF9U1jKqnj3zSyfYDD29oRPreV/MlbfR3HsNelZdLIN0hLHgnZRBeJ
         a1poFZRR9Dzw4+ONvWvcem2H8L3jyONITepgr8rOrQFGrZRrhNrvvvJfRdsa1S07Orx0
         XAuA==
X-Gm-Message-State: APjAAAVRW10y2NF57hbEQ+aIk1qpHca6mJkBS7KO2giZIAcFjzEUNQAw
        MtZQ1eEiLbAX/OI3s+WEODxUNsXD8jk=
X-Google-Smtp-Source: APXvYqzmWL9o2tasgjDQDMSea79AMfBCZ4NvuUGBmkxmdVNHGl/WslUNxLqX8+C88/8I5OdpvHgFgQ==
X-Received: by 2002:a1c:b404:: with SMTP id d4mr5757803wmf.9.1573585114766;
        Tue, 12 Nov 2019 10:58:34 -0800 (PST)
Received: from localhost.localdomain (82-75-169-199.cable.dynamic.v4.ziggo.nl. [82.75.169.199])
        by smtp.gmail.com with ESMTPSA id u18sm13017109wrp.14.2019.11.12.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:58:34 -0800 (PST)
From:   Kars de Jong <jongk@linux-m68k.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Cc:     linux-scsi@vger.kernel.org, linux-m68k@vger.kernel.org,
        schmitzmic@gmail.com, fthain@telegraphics.com.au,
        Kars de Jong <jongk@linux-m68k.org>
Subject: [PATCH 0/2] Some esp_scsi updates
Date:   Tue, 12 Nov 2019 19:57:08 +0100
Message-Id: <20191112185710.23988-1-jongk@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029220503.7553-1-jongk@linux-m68k.org>
References: <20191029220503.7553-1-jongk@linux-m68k.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When trying kernel 5.4.0-rc5 on my Amiga, I experienced data transfer failures
when reading from my FAST-10 SCSI disk. I have a Blizzard 12x0 IV SCSI
controller which uses a Symbios Logic SYM53CF94-2 "FSC" chip.

This used to work with the old generic NCR53C9x driver, so I investigated the
issue.

It turned out to be caused by lacking detection of FSC silicon in the new
driver.

The second patch in this series adds support for the FSC.

When adding support for the chip, I found out the hard way that the esp_rev
enum is ordered (I just added it to the end of the enum).

Then I also discovered that the definition for the PCSCSI chip was in the wrong
place of the enum. It will probably have issues with FAST-10 SCSI targets,
because its CONFIG3 settings are wrong.

The first patch fixes this, and adds comments to the enum to hopefully prevent
this from happening again.

When discussing this on the Linux/m68k mailing list, it was suggested to
perhaps replace the dependency on ordering of the esp_rev enum by feature flags.
I did not implement this for now.

Kars de Jong (2):
  esp_scsi: Correct ordering of PCSCSI definition in esp_rev enum
  esp_scsi: Add support for FSC chip

 drivers/scsi/esp_scsi.c | 22 +++++++++++++--------
 drivers/scsi/esp_scsi.h | 44 ++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.17.1

