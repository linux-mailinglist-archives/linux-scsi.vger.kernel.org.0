Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45C973020C
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jun 2023 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbjFNOdK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jun 2023 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245621AbjFNOdD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Jun 2023 10:33:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133C268B
        for <linux-scsi@vger.kernel.org>; Wed, 14 Jun 2023 07:32:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C235F67373; Wed, 14 Jun 2023 16:32:50 +0200 (CEST)
Date:   Wed, 14 Jun 2023 16:32:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, mwilck@suse.com, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v8 04/33] scsi: Have scsi-ml retry scsi_probe_lun errors
Message-ID: <20230614143250.GA23160@lst.de>
References: <20230614071719.6372-1-michael.christie@oracle.com> <20230614071719.6372-5-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614071719.6372-5-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
