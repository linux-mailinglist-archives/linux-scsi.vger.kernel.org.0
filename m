Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6219D633EDA
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Nov 2022 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiKVOYn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Nov 2022 09:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKVOYl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Nov 2022 09:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97CABC36
        for <linux-scsi@vger.kernel.org>; Tue, 22 Nov 2022 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669127026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=geVsTAOXAFmfC1p8NU5oUZW9hh2dqn+X7qlWo6CR96Y=;
        b=QD9HNhfwpjcZAyrcVDtGcyvcJC1Jt05Njs2nDDlxTHOvhswfgrgNAdHBiLEZ9+1+paIjfS
        xvMFD3qCbJf6A6xMlIn0VpgRM8BByfNqUyTTD/aKI8613kGDOh1+aFjPHhlm3ubdqQY76a
        4fjNNftK21PKnaEPXhuRK9+8oDaXYTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-clNrV_glOTiRpOT7AptSQA-1; Tue, 22 Nov 2022 09:23:45 -0500
X-MC-Unique: clNrV_glOTiRpOT7AptSQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5F22101A52A;
        Tue, 22 Nov 2022 14:23:42 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E09D61121325;
        Tue, 22 Nov 2022 14:23:33 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
Date:   Tue, 22 Nov 2022 09:23:29 -0500
Message-ID: <C3E8B434-BAEE-42A8-85AF-3B676C65B2A6@redhat.com>
In-Reply-To: <96114bec-1df7-0dcb-ec99-4f907587658d@linuxfoundation.org>
References: <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
 <cover.1669036433.git.bcodding@redhat.com>
 <382872.1669039019@warthog.procyon.org.uk>
 <51B5418D-34FB-4E87-B87A-6C3FCDF8B21C@redhat.com>
 <4585e331-03ad-959f-e715-29af15f63712@linuxfoundation.org>
 <26d98c8f-372b-b9c8-c29f-096cddaff149@linuxfoundation.org>
 <A860595D-5BAB-461B-B449-8975C0424311@redhat.com>
 <96114bec-1df7-0dcb-ec99-4f907587658d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 21 Nov 2022, at 17:32, Shuah Khan wrote:

> On 11/21/22 15:01, Benjamin Coddington wrote:
>> On 21 Nov 2022, at 16:43, Shuah Khan wrote:
>>
>>> On 11/21/22 14:40, Shuah Khan wrote:
>>>> On 11/21/22 07:34, Benjamin Coddington wrote:
>>>>> On 21 Nov 2022, at 8:56, David Howells wrote:
>>>>>
>>>>>> Benjamin Coddington <bcodding@redhat.com> wrote:
>>>>>>
>>>>>>> Since moving to memalloc_nofs_save/restore, SUNRPC has stopped se=
tting the
>>>>>>> GFP_NOIO flag on sk_allocation which the networking system uses t=
o decide
>>>>>>> when it is safe to use current->task_frag.
>>>>>>
>>>>>> Um, what's task_frag?
>>>>>
>>>>> Its a per-task page_frag used to coalesce small writes for networki=
ng -- see:
>>>>>
>>>>> 5640f7685831 net: use a per task frag allocator
>>>>>
>>>>> Ben
>>>>>
>>>>>
>>>>
>>>> I am not seeing this in the mainline. Where can find this commit?
>>>>
>>>
>>> Okay. I see this commit in the mainline. However, I don't see the
>>> sk_use_task_frag in mainline.
>>
>> sk_use_task_frag is in patch 1/3 in this posting.
>>
>> https://lore.kernel.org/netdev/26d98c8f-372b-b9c8-c29f-096cddaff149@li=
nuxfoundation.org/T/#m3271959c4cf8dcff1c0c6ba023b2b3821d9e7e99
>>
>
> Aha. I don't have 1/3 in my Inbox - I think it would make
> sense to cc people on the first patch so we can understand
> the premise for the change.

Yeah, I can do that if it goes to another version, I was just trying to b=
e
considerate of all the noise this sort of posting generates.

Ben

