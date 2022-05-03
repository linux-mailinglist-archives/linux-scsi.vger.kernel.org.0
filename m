Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901585186A1
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiECOap (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 May 2022 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiECOan (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 May 2022 10:30:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699631906
        for <linux-scsi@vger.kernel.org>; Tue,  3 May 2022 07:27:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D85167373; Tue,  3 May 2022 16:27:08 +0200 (CEST)
Date:   Tue, 3 May 2022 16:27:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 06/11] bfa: Do not use scsi command to signal TMF status
Message-ID: <20220503142708.GF24492@lst.de>
References: <20220502215416.5351-1-hare@suse.de> <20220502215416.5351-7-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502215416.5351-7-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, May 02, 2022 at 11:54:11PM +0200, Hannes Reinecke wrote:
> The bfa driver hijacks the scsi command to signal the TMF status,
> which will no longer work if the TMF handler will be converted.
> So rework TMF handling to not use a scsi command but rather add
> new TMF fields to the per-device structure.

This looks ok, but also a little sketchy.  Given how unmaintained the
bfa driver is, maybe it is time just drop it?
