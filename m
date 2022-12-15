Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9764D795
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Dec 2022 09:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLOIOX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Dec 2022 03:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLOIOV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Dec 2022 03:14:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3905933C0C
        for <linux-scsi@vger.kernel.org>; Thu, 15 Dec 2022 00:14:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9237D68AA6; Thu, 15 Dec 2022 09:14:17 +0100 (CET)
Date:   Thu, 15 Dec 2022 09:14:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     john.g.garry@oracle.com, bvanassche@acm.org, mwilck@suse.com,
        hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v3 08/15] scsi: sd: Convert to scsi_execute_cmd
Message-ID: <20221215081417.GD3308@lst.de>
References: <20221214235001.57267-1-michael.christie@oracle.com> <20221214235001.57267-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214235001.57267-9-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
