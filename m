Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1075C58FC24
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Aug 2022 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiHKM1o (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Aug 2022 08:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHKM1n (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Aug 2022 08:27:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98BC8E984
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 05:27:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A389E68AA6; Thu, 11 Aug 2022 14:27:38 +0200 (CEST)
Date:   Thu, 11 Aug 2022 14:27:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Martin Wilck <mwilck@suse.com>, bvanassche@acm.org, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com,
        Hannes Reinecke <Hannes.Reinecke@suse.com>
Subject: Re: [PATCH 3/4] scsi: Internally retry scsi_execute commands
Message-ID: <20220811122738.GC1742@lst.de>
References: <20220810034155.20744-1-michael.christie@oracle.com> <20220810034155.20744-4-michael.christie@oracle.com> <6149f7bdfa013e0352e59dee2669298b2c080a03.camel@suse.com> <2b1943b2-466f-5674-1c8c-7db7b2dc4738@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1943b2-466f-5674-1c8c-7db7b2dc4738@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 10, 2022 at 12:06:41PM -0500, Mike Christie wrote:
> 2. Instead of trying to make it general for all scsi_execute_users, we can
> add SCMD bits for specific cases like DID_TIME_OUT or a SCMD bit that tells
> scsi_noretry_cmd to not always fail passthrough commands just because they
> are passthrough. It would work the opposite of the FASTFAIL bits where instead
> of failing fast, we retry.

Yes, I think this is closer to what I'd like to see.   Although I wonder
if we should turn it around and require the FAILFAST bits to opt out of
automatic retries even for passthrough, even if that turns into a major
audit.
