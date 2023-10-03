Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528437B7364
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Oct 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjJCVci (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Oct 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVch (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 Oct 2023 17:32:37 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 14:32:34 PDT
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC3A1;
        Tue,  3 Oct 2023 14:32:34 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 9A49013DDF4; Tue,  3 Oct 2023 17:22:40 -0400 (EDT)
Date:   Tue, 3 Oct 2023 17:22:40 -0400
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v8 00/23] Fix libata suspend/resume handling and code
 cleanup
Message-ID: <ZRyGIE+NpmtMu7XK@thesusis.net>
References: <20230927141828.90288-1-dlemoal@kernel.org>
 <874jj8sia5.fsf@vps.thesusis.net>
 <87h6n87dac.fsf@vps.thesusis.net>
 <269e2876-58fd-b73c-0c0d-1593c17c2809@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269e2876-58fd-b73c-0c0d-1593c17c2809@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Oct 03, 2023 at 09:44:50AM +0900, Damien Le Moal wrote:
> Hmmm... So this could be the fs suspend then, which issues a sync but the device
> is already suspended and was synced already. In that case, we should turn that
> sync into a nop to not wakeup the drive unnecessarily. The fix may be needed on
> scsi sd side rather than libata.

I did some tracing today on a test ext4 fs I created on a loopback device, and it
seems that the superblocks are written every time you sync, even if no files on the
filesystem have even been opened for read access.
