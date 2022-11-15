Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1B6292FA
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Nov 2022 09:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiKOIKJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Nov 2022 03:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiKOIKI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Nov 2022 03:10:08 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598AB1CB25
        for <linux-scsi@vger.kernel.org>; Tue, 15 Nov 2022 00:10:07 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC9F167373; Tue, 15 Nov 2022 09:10:02 +0100 (CET)
Date:   Tue, 15 Nov 2022 09:10:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, mwilck@suse.com, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v6 02/35] scsi: Allow passthrough to override what
 errors to retry
Message-ID: <20221115081002.GA17445@lst.de>
References: <20221104231927.9613-1-michael.christie@oracle.com> <20221104231927.9613-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104231927.9613-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Nov 04, 2022 at 06:18:54PM -0500, Mike Christie wrote:
> +	if (!scmd->result || !scmd->failures)
> +		return SCSI_RETURN_NOT_HANDLED;

I'd probably move the ->result check into the caller to make it clear
thi code is a no-op for successful execution.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
