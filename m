Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0213534C45
	for <lists+linux-scsi@lfdr.de>; Thu, 26 May 2022 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiEZJIH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 May 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiEZJIG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 May 2022 05:08:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8E13F0F;
        Thu, 26 May 2022 02:08:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B6BD68B05; Thu, 26 May 2022 11:08:01 +0200 (CEST)
Date:   Thu, 26 May 2022 11:08:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 11/14] block: remove GENHD_FL_EXT_DEVT
Message-ID: <20220526090801.GA27200@lst.de>
References: <20211122130625.1136848-1-hch@lst.de> <20211122130625.1136848-12-hch@lst.de> <Yo4+zEnrBTnoEMCz@T590> <20220525165114.GA2750@lst.de> <Yo7uxyrD2BywxEHt@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo7uxyrD2BywxEHt@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 26, 2022 at 11:06:47AM +0800, Ming Lei wrote:
> BTW, SUPPRESS_PART_SCAN looks more like one flag, instead of 'state'.

It is kinda inbetween, but I favour the state.  ->flags is suppoed to be
set statically at initialization time, and the GENHD_FL_NO_PART usage
by loop is the only thing that violates it.  And once a device declares
support for partitions supresing the scans is basically a policy and thus
a state anyway.
