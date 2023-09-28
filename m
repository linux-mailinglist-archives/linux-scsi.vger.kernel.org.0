Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639097B1D98
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Sep 2023 15:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjI1NUm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Sep 2023 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjI1NUk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 28 Sep 2023 09:20:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050451A5;
        Thu, 28 Sep 2023 06:20:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80E56C07618;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907236;
        bh=jejSCWbFLCFF2dkjqTkEdiAPz2XEiyBfn7Kx6dJyBRE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=cZ7nyMzaaFGJTdj0cQqjiU1KLFU7WnEfcSz8Z8D1PNPaIUWfpiEvebX1GZG3Vu9xk
         pcCQC9yWnO5mDjBeYV68yUbfxRDGX0NUmqDLT9IPyXgaUbbXA2UKWfuTYHhsjplAVs
         sHYt++vYmu+132G0xpM5JpYteq3GwkUvZmpjMJ2kO4eAfNSzH/nteMMsaDWjkLc9D+
         Dab8WB+OuUjY9J4ifmA3HpOLo0eSGtZwKMnEb7ul//qTMBnvZ4PaJYrNi94a/7hF1c
         LKhHi0gdw60QhY+KcUG5P8VSRB3JuT1hyPOFvcUN+xR8XlYb3TwFJnXF93xwVUFv1d
         Y10RNqtfK6wXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 60545E732D1;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Thu, 28 Sep 2023 15:21:29 +0200
Subject: [PATCH 04/15] tty: Remove now superfluous sentinel element from
 ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-4-e59120fca9f9@samsung.com>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
In-Reply-To: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <song@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=8sTvUGRVDTp9H1bDylG6Zdr7SdjuawIyFt9Rw8abcOY=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3cdF4EIlnMzaDc9G1cMmQnLIu/8Bu3kPy9n
 QS3nW1BnkyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV93AAKCRC6l81St5ZB
 TymCC/93IOLpSBLeRvxqmQfi+lOXxSMU432q2hGOTJuwaFN4hoNYNr5JYby9ccthVv/ftgOHQWc
 M9C+kthX5+CFu7e0qqMVk/DE+aSJ4xeiApfapfP7GJjYu8sQ7XDPEVcqWSG0mWBUGo3CvDDgAXj
 VrOGclYbtMQ5oVdoJOzh/2ppeRTUPRIoeM/xZGcvNSsDeIPl0/3eOaTjZ5rXe5MVOagVGsiRTP3
 ezgKR03gT8Yingu9bLjUv7OnG9nl1QoJYIDP4/FVL1BTSUXU5yv7j77gZzRRQIbzk4ipEXAyv5c
 RrGUnHweFzoUFB4S3PkbWCKDKsNqwxU7WLvG2w5iAYfe/RYHS/0f9eRdcydszQ7u8ndwuDnCi9w
 uoQTfWDAeadPvRLvv6gnqZnsVQRFswvm9os0gC8/WUJizL51h0PN6Xk1tTcFBVrMNIOyHRONik8
 q0ZJIlhNLM4i70qg1sQ94ogeJkRyTF9X0puD9rr+5zpwm2KBw80tiFM1eim5U1g9W+n+o=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from tty_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..2f925dc54a20 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3607,8 +3607,7 @@ static struct ctl_table tty_table[] = {
 		.proc_handler	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 /*

-- 
2.30.2

