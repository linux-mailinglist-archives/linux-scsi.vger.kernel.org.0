Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B2458D460
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Aug 2022 09:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiHIHSI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Aug 2022 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiHIHSH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Aug 2022 03:18:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2820F42;
        Tue,  9 Aug 2022 00:18:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 082B068B05; Tue,  9 Aug 2022 09:18:04 +0200 (CEST)
Date:   Tue, 9 Aug 2022 09:18:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        hch@lst.de, linux-nvme@lists.infradead.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 16/20] scsi: Have sd pr_ops return a blk_status_t
Message-ID: <20220809071803.GB11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-17-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-17-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Aug 08, 2022 at 07:04:15PM -0500, Mike Christie wrote:
> This patch has the sd pr_ops convert from the low level SCSI errors to a
> blk_status_t.

Can you document the why here?
