Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A957E50E3
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Nov 2023 08:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjKHHW4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Nov 2023 02:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKHHWz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Nov 2023 02:22:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489301AC
        for <linux-scsi@vger.kernel.org>; Tue,  7 Nov 2023 23:22:53 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7F8F6732D; Wed,  8 Nov 2023 08:22:49 +0100 (CET)
Date:   Wed, 8 Nov 2023 08:22:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     mwilck@suse.com, bvanassche@acm.org, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH 1/1] scsi: sd: Fix sshdr use in sd_suspend_common
Message-ID: <20231108072249.GC4875@lst.de>
References: <20231106231304.5694-1-michael.christie@oracle.com> <20231106231304.5694-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106231304.5694-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
