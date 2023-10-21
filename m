Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA447D1E91
	for <lists+linux-scsi@lfdr.de>; Sat, 21 Oct 2023 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJURW7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 21 Oct 2023 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjJURW6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 21 Oct 2023 13:22:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF74126
        for <linux-scsi@vger.kernel.org>; Sat, 21 Oct 2023 10:22:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d895584f1so1321687f8f.1
        for <linux-scsi@vger.kernel.org>; Sat, 21 Oct 2023 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697908971; x=1698513771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0Pueci5vjE1RZUepv2ch3jnchuj0HDWR8j8LW6MAUg=;
        b=Z8wD/Wn7Oli4yv8WYye83wyEZY68ipsVF5gRBEhEPO0jY/nWZUo4Iod/1FRF2x4ZjF
         5IWYy5jY1fObDzV47dHcxL8vdT/ChbfKu8go1RD7vxS72AvQpFOdh478GAVneZel9xhS
         fdpzVtJiJh7WAzHXyKPICxVdwSfXTGTfJAjQ1EOUYsL9NdUxblZPp7OGQVgOjGm9/+Wy
         G4Gh+uexm31XLc0IGGOyOn3GB9XtWnqEaVPI7TOc1r8KnylGf8vGDA69DXEYCtcdLJK/
         0fUQvakiR+OpsaWMY1e9L5cLM+4kj41YwH9QqaRAbFZ02yFzhg+i47TfDsiz6LTe5pk6
         Dqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697908971; x=1698513771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0Pueci5vjE1RZUepv2ch3jnchuj0HDWR8j8LW6MAUg=;
        b=DJRIyqHKuTIR6lPjTa1lEElHwp4WUkLrv7rxM9ME3i7y2ZwirYTeIOjMxu6ZYXFCv4
         f9mjFojF5T931wO6nHdj2hXIHrJqadUbQTU7jdDwY24+GfZeXjxSPq9aYkOJ6YEd3lTZ
         Hrdfa248X6KFT6Tpd1NZ+lqHEKwNNvMjL7rNxhAwHkXtLen3p2VFjHOPHujfnPMu4G0R
         YEQ8EhobzUtN1Zd5oVjMgyS7P2ULbkGivM6P13Z9OqV1Gs0/vvRHnzvgsF7JfF/lmfyQ
         0KkT8F7Ysg/7vxkDA/KzKo5nEvD82wgzFm1Ym/qo19xa2n/FswkN7eH3fG+0KF7h+hdm
         9Zdg==
X-Gm-Message-State: AOJu0Yw1IgnVfmp4hKVKB8YmN/C4F272esc4B6X6VgR8wDGPZprR9bmi
        mX1YvS5DUWagzG96xY7QkzqlVg==
X-Google-Smtp-Source: AGHT+IHMbU19nFFzKe8Nu5N79q2KeQIpb+qOZCG1rQ+V69inj+F618FHlx4wadcGx+ZQo9ne2v6qIg==
X-Received: by 2002:a5d:650f:0:b0:32d:ad8b:2a04 with SMTP id x15-20020a5d650f000000b0032dad8b2a04mr3855209wru.14.1697908971540;
        Sat, 21 Oct 2023 10:22:51 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4852000000b0032db4e660d9sm4026394wrs.56.2023.10.21.10.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:22:51 -0700 (PDT)
Message-ID: <09de196b-94bc-4c0d-adf2-b02b2374a1f0@linaro.org>
Date:   Sat, 21 Oct 2023 19:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/4] dt-bindings: ufs: qcom: Add qos property
Content-Language: en-US
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com
References: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
 <1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com>
 <5458734c-b9ff-4351-9bcd-c3dd7538f135@linaro.org>
 <6a85761a-3dae-43fd-9b11-3d2edc56ad7e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6a85761a-3dae-43fd-9b11-3d2edc56ad7e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 10/20/23 11:04, Maramaina Naresh wrote:
> Hi All,
> 
> Thanks for reviewing the patch.
> 
> We are moving this feature support to core UFS driver and planning to control through UFS capability flag [ As per upstream comments ].
> 
> We will take care of comments and push new changes in next patch series.
Sounds good.

Please also fix your email client to avoid HTML. The lists will
only accept plaintext messages.

Konrad
