Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC07CBC40
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Oct 2023 09:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjJQHbW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Oct 2023 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjJQHbU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Oct 2023 03:31:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03C95
        for <linux-scsi@vger.kernel.org>; Tue, 17 Oct 2023 00:31:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE34E68D07; Tue, 17 Oct 2023 09:31:14 +0200 (CEST)
Date:   Tue, 17 Oct 2023 09:31:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] pmcraid: add missing scsi_device_put() in
 pmcraid_eh_target_reset_handler()
Message-ID: <20231017073113.GA12422@lst.de>
References: <20231017072145.120795-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017072145.120795-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Oct 17, 2023 at 09:21:45AM +0200, Hannes Reinecke wrote:
> (Re-sending as a separate patch:)
> When breaking out of a shost_for_each_device() loop one need to do
> an explicit scsi_device_put(). And while at it convert to use
> shost_priv() instead of a direct reference to ->hostdata.

This is still doing two entirely different things.  Please send just
the trivial scsi_device_put patch as a fix, and the cleanup on top.

