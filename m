Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160EE4FBFD2
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Apr 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbiDKPIh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Apr 2022 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiDKPIg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Apr 2022 11:08:36 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3462A241
        for <linux-scsi@vger.kernel.org>; Mon, 11 Apr 2022 08:06:21 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 2B9E9E10DB;
        Mon, 11 Apr 2022 15:06:20 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 16ABD627BF;
        Mon, 11 Apr 2022 15:06:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id yvTCUW1rTBUX; Mon, 11 Apr 2022 15:06:19 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 2AA3961620;
        Mon, 11 Apr 2022 15:06:18 +0000 (UTC)
Message-ID: <aa2a08cc-ba98-b538-2448-d528e8eef917@interlog.com>
Date:   Mon, 11 Apr 2022 11:06:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2 0/6] scsi: fix scsi_cmd::cmd_len
Content-Language: en-CA
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org
References: <20220410173652.313016-1-dgilbert@interlog.com>
 <20220411050325.GA13927@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20220411050325.GA13927@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022-04-11 01:03, Christoph Hellwig wrote:
> This still misses any good explanation of why we want all this.

Advantages:
    - undoes regression in ce70fd9a551af, that is:
        - cdb_len > 32 no longer allowed (visible to the user space), undone
        - but we still have this one:
            - prior to lk5.18 sizeof(scsi_cmnd::cmnd) is that of a
              pointer but >= lk5.18 sizeof(scsi_cmnd::cmnd) is 32 (or 16)
    - makes all scsi_cmnd objects 16 bytes smaller
    - hides the poorly named dtor for scsi_cmnd objects (blk_mq_free_request)
      within a more intuitively named inline: scsi_free_cmnd
    - scsi_free_cmnd() allows other cleanups to be hooked, like the one
      proposed to free the long CDB heap, if used
    - supplies three access functions for manipulating CDBs.
      scsi_cmnd_set_cdb() removes the need for memset()s and cdb[n]=0 code,
      and setting scsi_cmnd::cmd_len when ULDs and LLDs are building CDBs
    - allows scsi_cmnd::cmnd to be renamed scsi_cmnd::__cdb in the future
      to encourage the use of those access functions
    - patches to code accessing scsi_cmnd::cmnd change the name of a SCSI
      CDB (a byte array) to 'cdb' rather than the confusing terms: 'cmnd'
      or 'cmd'

Disadvantages:
     - burdens each access to a CDB with (scsi_cmnd::flags & SCMD_LONG_CDB)
       check
     - LLDs that want to fetch 32 byte CDBs (or longer) need to use the
       scsi_cmnd_get_cdb() access function. For CDB lengths <= 16 bytes
       they can continue to access scsi_cmnd::cmnd directly
