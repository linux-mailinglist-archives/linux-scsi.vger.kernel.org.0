Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6A635FFF
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Nov 2022 14:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiKWNev (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Nov 2022 08:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiKWNdL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Nov 2022 08:33:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30BD5800D
        for <linux-scsi@vger.kernel.org>; Wed, 23 Nov 2022 05:20:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09E6B68CFE; Wed, 23 Nov 2022 14:20:13 +0100 (CET)
Date:   Wed, 23 Nov 2022 14:20:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: do not put scsi_common in a separate module
Message-ID: <20221123132012.GA32386@lst.de>
References: <20221123131801.4409-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123131801.4409-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Nov 23, 2022 at 02:18:01PM +0100, Hannes Reinecke wrote:
> scsi_common.ko is a tiny module which is not shared with anything,
> so include it in scsi_mod.ko like the rest of the files.

It is shared between the scsi initiator and target code.
