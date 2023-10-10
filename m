Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27277BFCEC
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Oct 2023 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJJNKC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Oct 2023 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJNKB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Oct 2023 09:10:01 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F0A7;
        Tue, 10 Oct 2023 06:10:00 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 4F10B143E62; Tue, 10 Oct 2023 09:09:59 -0400 (EDT)
From:   Phillip Susi <phill@thesusis.net>
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paul Ausbeck <paula@soe.ucsc.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
In-Reply-To: <20230927141828.90288-5-dlemoal@kernel.org>
References: <20230927141828.90288-1-dlemoal@kernel.org>
 <20230927141828.90288-5-dlemoal@kernel.org>
Date:   Tue, 10 Oct 2023 09:09:59 -0400
Message-ID: <874jiybp3s.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Damien Le Moal <dlemoal@kernel.org> writes:

> system suspend/resume operations, the ATA port used to connect the
> device will also be suspended and resumed, with the resume operation
> requiring re-validating the device link and the device itself. In this
> case, issuing a VERIFY command to spinup the disk must be done before
> starting to revalidate the device, when the ata port is being resumed.
> In such case, we must not allow the SCSI disk driver to issue START STOP
> UNIT commands.

Why must a VERIFY be issued to spinup the disk before revalidating?
Before these patches, by default, manage_start_stop was on, and so sd
would cause a VERIFY in the system resume path.  That resume however (
sd and its issuing START UNIT ), would have happened AFTER the link was
resumed and the ATA device was revalidated, woudldn't it?  So at that
point, the drive would already be spinning.  And if manage_start_stop
was disabled, then there would be no VERIFY at all, and this did not
seem to cause a problem before.

If this VERIFY were skipped, the next thing that would happen is for
ata_dev_revalidate() to issue IDENTIFY, which would wait for the drive
to spin up before returning wouldn't it? ( unless the drive has PuiS
enabled ).
