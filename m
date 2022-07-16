Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F5576E4D
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Jul 2022 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiGPNuM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 16 Jul 2022 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPNuL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 16 Jul 2022 09:50:11 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0474B12AE6
        for <linux-scsi@vger.kernel.org>; Sat, 16 Jul 2022 06:50:11 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id s21so7929799pjq.4
        for <linux-scsi@vger.kernel.org>; Sat, 16 Jul 2022 06:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N8MPswfJTmjIdqPIAuEOmZ+nQprx1kxikV2FQ8K3TjY=;
        b=fkDX/PAXRkOTQx7PfRWBB5xdhL+1G3Ow0AG3COUAnNxR1N4kGWzhFJb53jbhyt43hW
         N4aKBKYmvne0ninyTWAfAZfWV7z/XTQGoa8q+7fHEwolTACQX8FFIoyfzqPpVNv5VJHA
         nNTR1FCmzlOLzyQBakS4zYfkkT971YtSukXXBkeWYsPKuveYorcWWiWlV5szxedcnsOQ
         8OLWEJTQ4t/SO31A/nNqLS2Tdh/4rOImVhyb8Kwjr/zaLDkQwD/zuaIVLHUXfvw9tm8/
         QEAxitAMrZnSEwp5u1HlClaQeDPvWP+yK6PMt4MBlJmc271EhItW1oGG6pnkvRG4Sw4r
         yE3Q==
X-Gm-Message-State: AJIora9lZAUffB8mNfEWQ4AMY5sl7aGBXL4QS8Jpa1pPKXPquOxIJ9mS
        9x9MErrGywbKUFCU+PqgbkgmfyxZ7RE=
X-Google-Smtp-Source: AGRyM1sfZu7jPT40VWFky/CFppXUpKskeMcRD96XaMEgFxw51nd5ZmEbnRiiy8RzBN1f0YpKk09d2w==
X-Received: by 2002:a17:902:9307:b0:166:41a8:abc0 with SMTP id bc7-20020a170902930700b0016641a8abc0mr19082578plb.135.1657979410440;
        Sat, 16 Jul 2022 06:50:10 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b0016c6e360ff2sm5548762pln.132.2022.07.16.06.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 06:50:09 -0700 (PDT)
Message-ID: <0209504a-fdd5-5987-4772-dfb14c6ceafc@acm.org>
Date:   Sat, 16 Jul 2022 06:50:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ufs: host: ufschd-pltfrm: Hold reference returned by
 of_parse_phandle()
Content-Language: en-US
To:     Liang He <windhl@126.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
References: <20220715001703.389981-1-windhl@126.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220715001703.389981-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/14/22 17:17, Liang He wrote:
> +static bool phandle_exists(const struct device_node *np,
> +						const char *phandle_name,
> +						int index)

Indentation of the arguments now looks really odd :-(

> +{
> +	struct device_node *parse_np = of_parse_phandle(np, phandle_name, index);
> +	bool ret = false;
> +
> +	if (parse_np) {
> +		ret = true;
> +		of_node_put(parse_np);
> +	}
> +
> +	return ret;
> +}

The 'ret' variable is not necessary. If "return ret" is changed into 
"return parse_np" then the variable 'ret' can be left out.

Thanks,

Bart.
